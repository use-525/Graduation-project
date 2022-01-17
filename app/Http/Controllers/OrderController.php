<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\Upgrade;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use App\Models\ModelHasRole;
use App\Models\Role;
use App\Models\ModelHasPermission;
use JamesDordoy\LaravelVueDatatable\Http\Resources\DataTableCollectionResource;

class OrderController extends Controller
{
    public function __construct()
    {
        $this->middleware(['header_api', 'auth:api']);
    }
    // all orders
    public function orders()
    {
        $orders = Order::all();
        $orders->load('upgrade');
        $orders->load('user');
        return response()->json([
            'status' => 'success',
            'messege' => 'Succsess get list orders',
            'data' => $orders,
        ], 200);
    }
    public function index(Request $request)
    {
        $query = Order::eloquentQuery(
            $request->input('column'),
            $request->input('dir'),
            $request->input('search'),
            [
                "upgrade", "user"
            ]
        );

        $data = $query->paginate($request->input('length'));
        return new DataTableCollectionResource($data);
    }
    // add order
    public function create(Request $request)
    {
        $latestOrder = Order::orderBy('created_at', 'DESC')->first();
        $order_id = $latestOrder->id ?? 1;
        $upgrade = Upgrade::find($request->upgrade_id);
        $period = $upgrade->period ?? 0;
        $user = User::where('email', $request->email_user)->first();

        $user_id = $user->id;
        $order = new Order([
            'order_nr' => strtoupper(date('dmy') . $order_id . Str::random(5)),
            'upgrade_id' => $request->upgrade_id,
            'user_id' => $user_id,
            'amount' => $upgrade->price ?? 1000,
            'status' => $request->status,
            'expiration' => Carbon::now()->addMonths($period),
        ]);
        $order->save();
        $roleName = '';
        switch ($upgrade->name) {
            case "Premium VIP1":
                $roleName = "UserVip1";
                $permission_id = [22, 23, 29, 32];
                break;
            case "Premium VIP2":
                $roleName = "UserVip2";
                $permission_id = [22, 23, 29, 32, 30];
                break;
            case "Premium VIP3":
                $roleName = "UserVip3";
                $permission_id = [22, 23, 29, 30, 31, 32];
                break;
            default:
                break;
        }
        $user_id = $order->user_id;
        $role = Role::where('name', $roleName)->first();
        $role_id = $role->id;
        ModelHasRole::where('model_id', $user_id)->delete();
        $userRole = new ModelHasRole([
            'role_id' => $role_id,
            'model_type' => User::class,
            'model_id' => $user_id,
        ]);
        $userRole->save();
        ModelHasPermission::where('model_id', $user_id)->delete();
        foreach ($permission_id as $id) {
            $model_has_permission = new ModelHasPermission([
                'permission_id' => $id,
                'model_id' => $user_id,
                'model_type' => User::class,
            ]);
            $model_has_permission->save();
        }

        return response()->json(['status' => 'success', 'message' => 'The order successfully added', 'data' => $order], 201);
    }

    // edit order
    public function show($id)
    {
        $order = Order::find($id);
        $order->load('user');
        $order->load('upgrade');
        return response()->json(['status' => 'success', 'message' => 'Succsess get order', 'data' => $order], 200);
    }

    // update order
    public function update($id, Request $request)
    {
        $rule = [
            'status' => 'required',
        ];
        $messages = [
            'status.required' => "Hãy chọn trạng thái.",
        ];

        $validator =  Validator::make($request->all(), $rule, $messages);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $order = Order::find($id);
        $order->update($request->all());
        if($order->status == 1){
        $upgrade = Upgrade::find($order->upgrade_id);
        $roleName = '';
        switch ($upgrade->name) {
            case "Premium VIP1":
                $roleName = "UserVip1";
                $permission_id = [22, 23, 29, 32];
                break;
            case "Premium VIP2":
                $roleName = "UserVip2";
                $permission_id = [22, 23, 29, 32, 30];
                break;
            case "Premium VIP3":
                $roleName = "UserVip3";
                $permission_id = [22, 23, 29, 30, 31, 32];
                break;
            default:
                break;
        }
        $user_id = $order->user_id;
        $role = Role::where('name', $roleName)->first();
        $role_id = $role->id;
        ModelHasRole::where('model_id', $user_id)->delete();
        $userRole = new ModelHasRole([
            'role_id' => $role_id,
            'model_type' => User::class,
            'model_id' => $user_id,
        ]);
        $userRole->save();
        ModelHasPermission::where('model_id', $user_id)->delete();
        foreach ($permission_id as $id) {
            $model_has_permission = new ModelHasPermission([
                'permission_id' => $id,
                'model_id' => $user_id,
                'model_type' => User::class,
            ]);
            $model_has_permission->save();
        }   
        }
        return response()->json(['status' => 'success', 'message' => 'The order successfully updated', 'data' => $order], 200);
    }

    // delete order
    public function delete($id)
    {
        $order = Order::find($id);
        $order->delete();

        return response()->json(['status' => 'success', 'message' => 'The order successfully deleted'], 200);
    }
    public function deleteMultiple(Request $request)
    {
       foreach ($request->order_id as $id ) {
        $order = Order::find($id);
        $order->delete();
       }
        return response()->json([
            'status'=>'success',
            'messege' => 'Succsess delete user',
        ], 200);
    }
    public function handleChart()
    {
        $amount = Order::select(DB::raw("SUM(amount) as sum"))
            ->where('status', '=', 1)
            ->whereYear('created_at', date('Y'))
            ->groupBy(DB::raw("Month(created_at)"))
            ->pluck('sum');

        $months = Order::select(DB::raw("Month(created_at) as month"))
            ->where('status', '=', 1)
            ->whereYear('created_at', date('Y'))
            ->groupBy(DB::raw("Month(created_at)"))
            ->pluck('month');

        $monthArr = [];
        $amountArr = [];
        foreach ($amount as $index => $y) {
            $amountArr[$index] = (int)$amount[$index];
        }
        foreach ($months as $index => $year) {
            $monthArr[$index] = $months[$index];
        }
        $data['month'] = $monthArr;
        $data['amount'] = $amountArr;
        // dd($data);
        return response()->json([
            'status' => 'success',
            'messege' => 'Succsess get data',
            'data' => $data,
        ], 200);
    }
}
