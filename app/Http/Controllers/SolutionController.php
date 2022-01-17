<?php

namespace App\Http\Controllers;

use App\Http\Requests\SaveSolutionRequest;
use App\Models\Challenge;
use App\Models\ChallengeCategory;
use App\Models\ChallengeUser;
use App\Models\Solution;
use App\Models\Upvote;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cookie;
use JamesDordoy\LaravelVueDatatable\Http\Resources\DataTableCollectionResource;

class SolutionController extends Controller
{
    public function __construct()
    {
        if (Cookie::get('token') != null) {
            $this->middleware(['header_api','auth:api']);
        }
    }
    // all Solutions
    public function solutions()
    {
        $solutions= Solution::all();
        $solutions->load('user');
        $solutions->load('challenge');
        $solutions->load('feedbacks');
        return response()->json([
            'status'=>'success',
            'messege' => 'Succsess get list solutions',
            'data' => $solutions,
        ], 200);
    }
    public function index(Request $request)
    {   
        $query = Solution::eloquentQuery(
            $request->input('column'),
            $request->input('dir'),
            $request->input('search'),
            [
                "feedbacks","challenge","user","upvote"
            ],
           
        );
        $data = $query->paginate($request->input('length'));
        return new DataTableCollectionResource($data);
    }
    //get detail solution with id solution
    public function detailSolution($id){
        $solution = Solution::find($id);
        $solution->load('user');
        $solution->load('feedbacks');
        $solution->load('upvote');
        return response()->json(['status'=>'success','message'=>'Get solution successfully','data'=>$solution],200);
    }

    //get all solution same category
    public function categorySolution($slug){
       $solutions = Solution::select('solutions.*')
        ->join('challenges', 'solutions.challen_id', '=', 'challenges.id')
        ->join('challenge_categories', 'challenges.cate_challen_id', '=', 'challenge_categories.id')
        ->where('challenge_categories.slug',$slug)
        ->with('user')
        ->with('challenge')
        ->with('feedbacks')
        ->with('upvote')
        ->get();
        return response()->json(['status'=>'success','message'=>'Get solution successfully','data'=>$solutions],200);
    }
    // add Solution
    public function create(SaveSolutionRequest $request)
    {
        $solution = new Solution([
            'title' => $request->title,
            'description' => $request->description,
            'link_github' => $request->link_github,
            'demo_url' => $request->demo_url,
            'user_id' => Auth::id(),
            'challen_id' => $request->challen_id,
        ]);
        $solution->save();
        $chall_user = ChallengeUser::where('challen_id','=',$request->challen_id)->where('user_id','=',Auth::id())->first();
        $chall_user->status=1;
        $chall_user->save();
        return response()->json(['status'=>'success','message'=>'The solution successfully added','data'=>$solution],201);
    }

    // edit Solution
    public function show($id)
    {
        $solution = Solution::find($id);
        $solution->load('user');
        $solution->load('challenge');
        $solution->load('feedbacks');
        $solution->load('upvote');
        $solution['challenges'] = Challenge::all();
        return response()->json(['status'=>'success','message'=>'get the solution successfully','data'=>$solution],200);
    } 

    // update Solution
    public function update($id, SaveSolutionRequest $request)
    {
        $solution = Solution::find($id);
        $solution->update($request->all());

        return response()->json(['status'=>'success','message'=>'The solution successfully updated','data'=>$solution],200);
    }

    // delete Solution
    public function delete($id)
    {
        $solution = Solution::find($id);
        $solution->delete();

        return response()->json(['status'=>'success','message'=>'The solution successfully delete','data'=>$solution],200);
    }
    public function deleteMultiple(Request $request)
    {
       foreach ($request->solution_id as $id ) {
        $solution = Solution::find($id);
        $solution->delete();
       }
        return response()->json([
            'status'=>'success',
            'messege' => 'Succsess delete user',
        ], 200);
    }
    public function checkSolutionChall($slug){
        $chall = Challenge::where('slug',$slug)->first();
        $solution = Solution::where('challen_id','=',$chall->id)->where('user_id','=',Auth::id())->first();
        
        return response()->json(['status'=>'success','message'=>'Success get solution','data'=>$solution],200);
    }
    public function editSolutionChall(SaveSolutionRequest $request,$slug)
    {
        $chall = Challenge::where('slug',$slug)->first();
        $solution = Solution::where('challen_id','=',$chall->id)->where('user_id','=',Auth::id())->first();
       
        if($solution){
            $solution->title = $request->title;
            $solution->description = $request->description;
            $solution->link_github = $request->link_github;
            $solution->demo_url = $request->demo_url;
            $solution->save();
        }
        return response()->json(['status'=>'success','message'=>'Success get solution','data'=>$solution],200);
    }
    public function upvote($id)
    {
        $upvote = Upvote::where('solution_id','=',$id)->where('user_id','=',Auth::id())->first(); 
        if($upvote){
            Upvote::where('solution_id','=',$id)->where('user_id','=',Auth::id())->delete();
        }else{
            $upvote = new Upvote([
                'solution_id' => $id,
                'user_id' => Auth::id(),
            ]);
            $upvote->save();
        }
        return response()->json(['status'=>'success','message'=>'The upvote successfully updated','data'=>$upvote],200);
    }
    public function checkUpvote($id)
    {
        $upvote = Upvote::where('solution_id','=',$id)->where('user_id','=',Auth::id())->first(); 
        if($upvote){
            $check =true;
        }else{
           $check=false;
        }
        return response()->json(['status'=>'success','data'=>$check],200);
    }
    public function challengeUser()
    {
        $data = [];
        $data['challenges'] = Challenge::join('challenge_users', 'challenges.id', '=', 'challenge_users.challen_id')
        ->select('challenges.*')
        ->where('challenge_users.user_id','=',Auth::id())
        ->where('challenge_users.status','=',0)
        ->get();
        
        $solutions = Solution::where('user_id','=',Auth::id())->get();
        $solutions->load('feedbacks');
        $solutions->load('challenge');
        $solutions->load('upvote');
        $data['solutions']= $solutions;
        $data['upvotes'] = Upvote::where('user_id','=',Auth::id())->get();
        return response()->json(['status'=>'success','data'=>$data],200);
    }
    public function portfolio($username)
    {
        $data=[];
        $data['solutions'] = Solution::select('solutions.*','challenge_categories.name as category_name')
        ->join('users', 'solutions.user_id', '=', 'users.id')
        ->join('challenges', 'solutions.challen_id', '=', 'challenges.id')
        ->join('challenge_categories', 'challenges.cate_challen_id', '=', 'challenge_categories.id')
        ->where('users.username','=',$username)
        ->with('challenge')
        ->get();
        $data['user'] = User::where('username','=',$username)->first();
        return response()->json(['status'=>'success','message'=>'Get solution successfully','data'=>$data],200);
    }

}
