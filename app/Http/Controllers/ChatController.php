<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ChatMessage;
use App\Models\ChatRoom;
use Illuminate\Support\Facades\Auth;
use App\Events\NewChatMessage;
use App\Events\PrivateMessageSent;
use App\Models\User;

class ChatController extends Controller
{
    //
    public function rooms()
    {
        return response()->json([
            'status' => 'success',
            'messege' => 'Succsess get list rooms',
            'data' => ChatRoom::all(),
        ], 200);
    }
    public function messages( $roomId)
    {
        $ChatMessage = ChatMessage::where('chat_room_id', $roomId)
            ->with('user')
            ->get();
        return response()->json([
            'status' => 'success',
            'messege' => 'Succsess get messeges',
            'data' => $ChatMessage,
        ], 200);
    }
    public function privateMessages($id)
    {
        $privateCommunication= ChatMessage::with('user')
        ->where(['user_id'=> Auth::id(), 'receiver_id'=> $id])
        ->orWhere(function($query) use($id){
            $query->where(['user_id' => $id, 'receiver_id' => Auth::id()]);
        })
        ->get();

        return response()->json([
            'status' => 'success',
            'messege' => 'Succsess get messeges',
            'data' => $privateCommunication,
        ], 200);
    }
    public function newMessage(Request $request, $roomId)
    {
        if(request()->has('file')){
            $image = time().'-'.$request->file->getClientOriginalName();
            $request->file->move(public_path('files'),$image);
            $filename = 'files/'.$image;
            $newMessage = new ChatMessage;
            $newMessage->user_id  = Auth::id();
            $newMessage->chat_room_id = $roomId;
            $newMessage->image = $filename;
            $newMessage->save();
        }else{
            $newMessage = new ChatMessage;
            $newMessage->user_id  = Auth::id();
            $newMessage->chat_room_id = $roomId;
            $newMessage->message = $request->message;
            $newMessage->save();
        }
        broadcast(new NewChatMessage($newMessage))->toOthers();
        return response()->json([
            'status' => 'success',
            'messege' => 'Succsess get new message',
            'data' => $newMessage,
        ], 200);
    }
    public function sendPrivateMessage(Request $request, $id)
    {
        if(request()->has('file')){
            $image = time().'-'.$request->file->getClientOriginalName();
            $request->file->move(public_path('files'),$image);
            $filename = 'files/'.$image;
            $message = new ChatMessage;
            $message->user_id  = Auth::id();
            $message->receiver_id = $id;
            $message->image = $filename;
            $message->save();
        }else{
            $message = new ChatMessage;
            $message->user_id  = Auth::id();
            $message->receiver_id = $id;
            $message->message = $request->message;
            $message->save();
        }

        broadcast(new PrivateMessageSent($message->load('user')))->toOthers();
        return response(['status'=>'Message private sent successfully','message'=>$message],200);
        // return response()->json([
        //     'status' => 'success',
        //     'messege' => 'Succsess get new message',
        //     'data' => $message,
        // ], 200);

    }
    
    public function searchPrivate($search)
    {
        $users = User::where('name','like','%'.$search.'%')->get();
        $users->load('roles');
        $users->load('challenges');
        $users->load('solutions');
        return response()->json([
            'status'=>'success',
            'messege' => 'Succsess get list users',
            'data' => $users,
        ], 200);
    }

    public function searchGroup($search)
    {
        $rooms = ChatRoom::where('name','like','%'.$search.'%')->get();
        return response()->json([
            'status'=>'success',
            'messege' => 'Succsess get list rooms',
            'data' => $rooms,
        ], 200);
    }
}
