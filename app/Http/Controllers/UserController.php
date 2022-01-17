<?php

namespace App\Http\Controllers;

use App\Http\Requests\SaveUserRequest;
use App\Models\Challenge;
use App\Models\ModelHasPermission;
use App\Models\ModelHasRole;
use App\Models\Permission;
use App\Models\Role;
use App\Models\Solution;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use App\Exports\UsersExport;
use Maatwebsite\Excel\Facades\Excel;
use JamesDordoy\LaravelVueDatatable\Http\Resources\DataTableCollectionResource;
class UserController extends Controller
{
    public function __construct()
    {
        $this->middleware(['header_api', 'auth:api']);
    }
   /**
     * Get authenticated user.
     *
     * @param  \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse
     */
   
    // all users
    public function users()
    {
        $users= User::all();
        $users->load('roles');
        $users->load('challenges');
        $users->load('solutions');
        return response()->json([
            'status'=>'success',
            'messege' => 'Succsess get list users',
            'data' => $users,
        ], 200);
    }

    public function index(Request $request)
    {   
        $query = User::eloquentQuery(
            $request->input('column'),
            $request->input('dir'),
            $request->input('search'),
            [
                "roles","challenges","solutions"
            ],
           
        );
        $data = $query->paginate($request->input('length'));
        return new DataTableCollectionResource($data);
    }
    public function mentors(Request $request)
    {   
        $query = User::where('model_has_roles.role_id','=',7)
        ->eloquentQuery(
            $request->input('column'),
            $request->input('dir'),
            $request->input('search'),
            [
                "roles","challenges","solutions"
            ],
           
        );
        $data = $query->paginate($request->input('length'));
        return new DataTableCollectionResource($data);
    }
    // add user -> add user_role
    public function create(SaveUserRequest $request)
    {
        $this->validate($request, [
            'password' => ['required','min:6'],
        ]);
        $imageName='';
        if($request->is_active==true){
            $is_active = 1;
        }else{
            $is_active=0;
        }
        if ($request->hasFile('image')) {
           $image = time().'-'.$request->image->getClientOriginalName();
           $request->image->move(public_path('files'),$image);
           $imageName = 'files/'.$image;
        }
        $user = new User([
            'username' => $request->username,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'image'=> $imageName,
            'is_active'=>$is_active,
            'name'=>$request->name,
            'phone'=>$request->phone,
            'gender'=>$request->gender,
            'address'=>$request->address
        ]);
        $user->save();
      
        $userRole = new ModelHasRole([
            'role_id'=> $request->role_id,
            'model_type'=> User::class,
            'model_id' => $user->id,
        ]);
        $userRole->save();
        foreach ($request->permission_id as $id) {
            $model_has_permission = new ModelHasPermission([
                'permission_id' => $id,
                'model_id'=> $user->id,
                'model_type'=> User::class,
            ]);
            $model_has_permission->save();
        }
        return response()->json(['status'=>'success','message'=>'The user successfully added','data'=>$user],201);
    }

    // edit user
    public function show($id)
    {
        $data=[];
        $data['user'] = User::find($id);
        $data['user']['role'] = ModelHasRole::where('model_id',$id)->first();
        $data['roles']=Role::all();
        $data['user']->load('hasPermission');
        $data['permissions']= Permission::all();
        return response()->json(['status'=>'success','message'=>'Succsess get user','data'=>$data],200);
    }

    // update user
    public function update($id, SaveUserRequest $request)
    {
        if($request->is_active==true){
            $is_active = 1;
        }else{
            $is_active=0;
        }
        $user = User::find($id);
        $imageName = $user->image;
        if ($request->hasFile('image')) {
            $rule= [
                'image' => 'image',
              ];
              $messages = [
                  'image.image' => "Phải là một hình ảnh.",
              ];
         
            $validator =  Validator::make($request->all(),$rule,$messages);
            if ($validator->fails()) { 
                return response()->json(['errors'=>$validator->errors()],422);
            }
            $image = $request->file('image');
            $images = time().'-'.$image->getClientOriginalName();
            $image->move(public_path('files'),$images);
            $imageName = 'files/'.$images;
            File::delete($user->image);
        }
         $user->username = $request->username;
         $user->email = $request->email;
         $user->name = $request->name;
         $user->phone = $request->phone;
         $user->gender = $request->gender;
         $user->address = $request->address;
         $user->image = $imageName;
         $user->is_active = $is_active;
         $user->save();
         
        ModelHasRole::where('model_id',$id)->delete();
        $userRole = new ModelHasRole([
            'role_id'=> $request->role_id,
            'model_type'=> User::class,
            'model_id' => $id,
        ]);
        $userRole->save();

        ModelHasPermission::where('model_id',$id)->delete();
        foreach ($request->permission_id as $id) {
           $model_has_permission = new ModelHasPermission([
               'permission_id' => $id,
               'model_id'=> $user->id,
               'model_type'=> User::class,
           ]);
           $model_has_permission->save();
       }
        return response()->json([
            'status'=>'success',
            'messege' => 'The user successfully updated','data'=>$user
        ], 200);
    }

    // delete user
    public function delete($id)
    {
        $user = User::find($id);
        File::delete($user->image);
        $user->delete();

        return response()->json([
            'status'=>'success',
            'messege' => 'Succsess delete user',
        ], 200);
    }
    public function deleteMultiple(Request $request)
    {
       foreach ($request->user_id as $id ) {
            $user = User::find($id);
            File::delete($user->image);
            $user->delete();
       }
        return response()->json([
            'status'=>'success',
            'messege' => 'Succsess delete user',
        ], 200);
    }
    public function export() 
    {
        return Excel::download(new UsersExport, 'users.xlsx');
    }
    public function chartUser()
    {
        $countUser = User::select(DB::raw("COUNT(*) as sum"))
                ->whereYear('created_at', date('Y'))
                ->groupBy(DB::raw("Month(created_at)"))
                ->pluck('sum');

        $months = User::select(DB::raw("Month(created_at) as month"))
                ->whereYear('created_at', date('Y'))
                ->groupBy(DB::raw("Month(created_at)"))
                ->pluck('month');

        $user = array(0,0,0,0,0,0,0,0,0,0,0,0);
        foreach($months as $index => $month)
        {
            $user[$month-1] = (int)$countUser[$index];
        }

        $countChall = Challenge::select(DB::raw("COUNT(*) as sum"))
                ->whereYear('created_at', date('Y'))
                ->groupBy(DB::raw("Month(created_at)"))
                ->pluck('sum');

        $monthsChall = Challenge::select(DB::raw("Month(created_at) as month"))
                ->whereYear('created_at', date('Y'))
                ->groupBy(DB::raw("Month(created_at)"))
                ->pluck('month');

        $challenge = array(0,0,0,0,0,0,0,0,0,0,0,0);
        foreach($monthsChall as $index => $month)
        {
            $challenge[$month-1] = (int)$countChall[$index];
        }

        $countSolution = Solution::select(DB::raw("COUNT(*) as sum"))
                ->whereYear('created_at', date('Y'))
                ->groupBy(DB::raw("Month(created_at)"))
                ->pluck('sum');

        $monthsSolution = Solution::select(DB::raw("Month(created_at) as month"))
                ->whereYear('created_at', date('Y'))
                ->groupBy(DB::raw("Month(created_at)"))
                ->pluck('month');

        $solution = array(0,0,0,0,0,0,0,0,0,0,0,0);
        foreach($monthsSolution as $index => $month)
        {
            $solution[$month-1] = (int)$countSolution[$index];
        }

        $data['user']=$user;
        $data['challenge']=$challenge;
        $data['solution']=$solution;

        return response()->json([
            'status'=>'success',
            'messege' => 'Succsess get list users',
            'data' => $data,
        ], 200);
    }
    public function profile($id, Request $request)
    {
        $user = User::find($id);

         $rule= [
            'username' => ['required','min:4',Rule::unique('users')->ignore($user->id)],
            'name' => ['required','min:2'],
            'email' => [
                'required',
                'email',
                Rule::unique('users')->ignore($user->id)
            ],
            //'gender'=>['required'],
            'phone'=>['required',Rule::unique('users')->ignore($user->id)],
          ];
          $messages = [
            'username.required' => "Hãy nhập tên tài khoản",
            'username.min' => "Ít nhất có 4 ký tự",
            'username.unique' => "Tên tài khoản đã tồn tại",
            'name.required' => "Hãy nhập họ tên",
            'name.min' => "Ít nhất có 2 ký tự",
            'email.required' => "Hãy nhập email",
            'email.email' => "Không đúng định dạng",
            'email.unique' => "Email đã tồn tại",
            //'gender.required' => "Hãy chọn giới tính",
            'phone.required' => "Hãy nhập SDT",
            'phone.unique' => "SDT đã tồn tại",
          ];
     
        $validator =  Validator::make($request->all(),$rule,$messages);
        if ($validator->fails()) { 
            return response()->json(['errors'=>$validator->errors()],422);
        }
        $imageName = $user->image;
        if ($request->hasFile('image')) {
            $rule= [
                'image' => 'image',
              ];
              $messages = [
                  'image.image' => "Phải là một hình ảnh.",
              ];
         
            $validator =  Validator::make($request->all(),$rule,$messages);
            if ($validator->fails()) { 
                return response()->json(['errors'=>$validator->errors()],422);
            }
            $image = $request->file('image');
            $images = time().'-'.$image->getClientOriginalName();
            $image->move(public_path('files'),$images);
            $imageName = 'files/'.$images;
            File::delete($user->image);
        }
         $user->username = $request->username;
         $user->email = $request->email;
         $user->name = $request->name;
         $user->phone = $request->phone;
         $user->gender = $request->gender;
         $user->address = $request->address;
         $user->image = $imageName;
         $user->save();
        return response()->json([
            'status'=>'success',
            'messege' => 'The user successfully updated','data'=>$user
        ], 200);
    }
    public function changePass(Request $request)
    {
        $rule= [
            'password' => 'required|min:6',
            'new_password' => 'required|min:6',
            'new_confirm_password' => 'required|same:new_password'
          ];
          $messages = [
              'password.min' => "Ít nhất có 6 ký tự",
              'password.required' => "Nhập mật khẩu",
              'new_password.min' => "Ít nhất có 6 ký tự",
              'new_password.required' => "Nhập mật khẩu mới",
              'new_confirm_password.required' => "Xác nhận mật khẩu",
              'new_confirm_password.same' => "Mật khẩu xác nhận không khớp",
          ];
     
          $validator =  Validator::make($request->all(),$rule,$messages);
            if ($validator->fails()) { 
              return response()->json(['errors'=>$validator->errors()],422);
            }
        $user = User::find($request->id);
           if (Hash::check($request->password, $user->password)) {
                $user->password = Hash::make($request->new_password);
                $user->save();
                return response()->json([
                'status' => 'success',
                ]);
           }else{
            return response()->json(['errors' => ['password'=> ['Mật khẩu không đúng']]], 
            422);
           }
    }
    public function createPass(Request $request)
    {
        $rule= [
            'password' => 'required|min:6',
            'confirm_password' => 'required|same:password'
          ];
          $messages = [
              'password.min' => "Ít nhất có 6 ký tự",
              'password.required' => "Nhập mật khẩu",
              'confirm_password.required' => "Xác nhận mật khẩu",
              'confirm_password.same' => "Mật khẩu xác nhận không khớp",
          ];
     
          $validator =  Validator::make($request->all(),$rule,$messages);
            if ($validator->fails()) { 
              return response()->json(['errors'=>$validator->errors()],422);
            }
        $user = User::find($request->id);
            $user->password = Hash::make($request->password);
            $user->save();
            return response()->json([
            'status' => 'success',
            ]);
    }

    public function chatUser()
    {
        $users= User::select('users.*')->join('model_has_roles', 'users.id', '=', 'model_has_roles.model_id')
        ->join('roles', 'model_has_roles.role_id', '=', 'roles.id')
        ->where('model_has_roles.role_id','=',2)->orWhere('model_has_roles.role_id','=',7)->get();
        $users->load('roles');
        $users->load('challenges');
        $users->load('solutions');
        return response()->json([
            'status'=>'success',
            'messege' => 'Succsess get list users',
            'data' => $users,
        ], 200);
    }
}
