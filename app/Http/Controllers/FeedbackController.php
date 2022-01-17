<?php

namespace App\Http\Controllers;

use App\Models\Feedback;
use App\Models\UpvoteFeedback;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cookie;
use Illuminate\Support\Facades\Validator;
use JamesDordoy\LaravelVueDatatable\Http\Resources\DataTableCollectionResource;

class FeedbackController extends Controller
{
    public function __construct()
    {
        if (Cookie::get('token') != null) {
            $this->middleware(['header_api','auth:api']);
        }
    }
   // all feedbacks
   public function feedbacks()
   {
       $feedbacks = Feedback::all();
       $feedbacks->load('solutions');
       $feedbacks->load('users');
        return response()->json([
            'status'=>'success',
            'messege' => 'Succsess get list feedback',
            'data' => $feedbacks,
        ], 200);
   }
   
   public function index(Request $request)
   {   
       $query = Feedback::eloquentQuery(
           $request->input('column'),
           $request->input('dir'),
           $request->input('search'),
           [
               "solutions","users","upvote"
           ],
          
       );
       $data = $query->paginate($request->input('length'));
       return new DataTableCollectionResource($data);
   }
   // add feedback
   public function create(Request $request)
   {
    $rule= [
        'feedback_content' => 'required|min:2',
      ];
      $messages = [
          'feedback_content.min' => "Ít nhất có 2 ký tự",
          'feedback_content.required' => "Nhập nội dung",
      ];
 
      $validator =  Validator::make($request->all(),$rule,$messages);
        if ($validator->fails()) { 
          return response()->json(['errors'=>$validator->errors()],422);
        }
       $parent_id = 0;
       if(isset($request->parent_id)){
        $parent_id = $request->parent_id;
       }
       $feedback = new Feedback([
           'feedback_content' => $request->feedback_content,
           'user_id' => Auth::id(),  //user logined
           'solution_id' => $request->solution_id,
           'parent_id' => $parent_id,
       ]);
       $feedback->save();

       return response()->json(['status'=>'success','message'=>'The feedback successfully added','data'=>$feedback],201);
   }

   // edit feedback
   public function show($id)
   {
       $feedback = Feedback::find($id);
       return response()->json(['status'=>'success','message'=>'get the feedback successfully','data'=>$feedback],200);
   }

   // update feedback
   public function update($id, Request $request)
   {
       $feedback = Feedback::find($id);
       $feedback->update($request->all());

       return response()->json(['status'=>'success','message'=>'The feedback successfully updated','data'=>$feedback],200);
   }
   // update feedback
   public function updateApproved($id)
   {
       $feedback = Feedback::find($id);
       $feedback->is_approved=1;
       $feedback->save();

       return response()->json(['status'=>'success','message'=>'The feedback successfully updated','data'=>$feedback],200);
   }
   public function solutionFeedbackTable(Request $request,$solution_id)
   {   
       $query = Feedback::where('solution_id',$solution_id)->eloquentQuery(
           $request->input('column'),
           $request->input('dir'),
           $request->input('search'),
           [
               "users"
           ],
          
       );
       $data = $query->paginate($request->input('length'));
       return new DataTableCollectionResource($data);
   }
   // delete feedback
   public function delete($id)
   {
       $feedback = Feedback::find($id);
       $feedbacks = Feedback::where('parent_id','=',$feedback->id)->delete();
       $feedback->delete();

       return response()->json(['status'=>'success','message'=>'The feedback successfully deleted','data'=>$feedback],200);
   }
   public function deleteMultiple(Request $request)
    {
       foreach ($request->feedback_id as $id ) {
        $feedback = Feedback::find($id);
        $feedbacks = Feedback::where('parent_id','=',$feedback->id)->delete();
        $feedback->delete();
       }
        return response()->json([
            'status'=>'success',
            'messege' => 'Succsess delete user',
        ], 200);
    }
   public function feedbackSolutions($solution_id)
   {   
       $feedback = Feedback::orderByDesc('id')->where('solution_id',$solution_id)->where('is_approved','=',1)->get();
       $feedback->load('users');
       $feedback->load('upvote');
       $data= $this->data_tree($feedback);
       return response()->json(['status'=>'sudataess','message'=>'The feedback successfully','data'=>$data],200);
   }
   public function data_tree($data, $parent_id = 0, $level = 0){
    $result = [];
    foreach($data as $key => $item){
        if($item['parent_id'] == $parent_id){
            $item['level'] = $level;
            $result[] = $item;
            unset($data[$item[$key]]);
            $child = $this->data_tree($data, $item['id'], $level + 1 );
            $result = array_merge($result, $child);
        }
    }
    return $result;
    }
    public function upvote($id)
    {
        $upvote = UpvoteFeedback::where('feedback_id','=',$id)->where('user_id','=',Auth::id())->first(); 
        if($upvote){
            UpvoteFeedback::where('feedback_id','=',$id)->where('user_id','=',Auth::id())->delete();
        }else{
            $upvote = new UpvoteFeedback([
                'feedback_id' => $id,
                'user_id' => Auth::id(),
            ]);
            $upvote->save();
        }
        return response()->json(['status'=>'success','message'=>'The upvote successfully updated','data'=>$upvote],200);
    }
    //get all feedbacks with category
    public function feedbackGetByCate($slug)
    {
        $feedbacks = Feedback::orderBy('solutions.created_at', 'desc')->orderByDesc('id')->select('feedbacks.*','users.image as avatar','challenges.image','users.name')
        ->join('solutions', 'feedbacks.solution_id', '=', 'solutions.id')
        ->join('challenges', 'solutions.challen_id', '=', 'challenges.id')
        ->join('users', 'solutions.user_id', '=', 'users.id')
        ->join('challenge_categories', 'challenges.cate_challen_id', '=', 'challenge_categories.id')
        ->where('challenge_categories.slug',$slug)
        ->with('users')
        ->with('solutions')
        ->with('upvote')
        ->where('is_approved','=',1)
        ->get();
        $data= $this->data_tree($feedbacks);
        return response()->json(['status'=>'success','message'=>'Get solution successfully','data'=>$data],200);
    }
}
