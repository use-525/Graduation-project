<?php

namespace App\Http\Controllers;

use App\Http\Requests\NotificationRequest;
use App\Models\Notification;
use App\Models\User;
use Illuminate\Http\Request;
use JamesDordoy\LaravelVueDatatable\Http\Resources\DataTableCollectionResource;
use Illuminate\Support\Facades\Auth;
class NotificationController extends Controller
{
    public function __construct()
    {
        $this->middleware(['header_api','auth:api']);
    }
    public function index(Request $request)
    {   
        $query = Notification::eloquentQuery(
            $request->input('column'),
            $request->input('dir'),
            $request->input('search'),
            [
                "user"
            ],
           
        );
        $data = $query->paginate($request->input('length'));
        return new DataTableCollectionResource($data);
    }
     // add notification
     public function create(NotificationRequest $request)
     {
         $notification = new Notification([
             'title' => $request->title,
             'content'=>$request->content,
             'user_id'=>$request->user_id,
         ]);
         $notification->save();
 
         return response()->json(['status'=>'success','message'=>'The notification successfully added','data'=>$notification],201);
     }
 
     // edit notification
     public function show($id)
     {
         $notification = Notification::find($id);
         $notification['users']= User::all();
         return response()->json(['status'=>'success','message'=>'Succsess get notification','data'=>$notification],200);
     }
 
     // update notification
     public function update($id, NotificationRequest $request)
     {
         $notification = Notification::find($id);
         $notification->update($request->all());
 
         return response()->json(['status'=>'success','message'=>'The notification successfully updated','data'=>$notification],200);
     }
 
     // delete notification
     public function delete($id)
     {
         $notification = Notification::find($id);
         $notification->delete();
 
         return response()->json(['status'=>'success','message'=>'The notification successfully deleted'],200);
     }
     public function deleteMultiple(Request $request)
    {
       foreach ($request->notification_id as $id ) {
        $notification = Notification::find($id);
        $notification->delete();
       }
        return response()->json([
            'status'=>'success',
            'messege' => 'Succsess delete user',
        ], 200);
    }
     public function notificationByUser()
     {
         $data=[];
         $data['notification'] = Notification::where('user_id','=',Auth::id())->orderByDesc('id')->get();
         $data['notifi_new'] = Notification::where('user_id','=',Auth::id())->where('is_read','=',false)->orderByDesc('id')->get();
         return response()->json(['status'=>'success','message'=>'Succsess get notification','data'=>$data],200);
     }
     public function markAsRead($id)
     {
        $notification = Notification::find($id);
        $notification->is_read = true;
        $notification->save();
        return response()->json(['status'=>'success','message'=>'The notification successfully updated','data'=>$notification],200);
     }
}
