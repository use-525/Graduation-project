<?php

namespace App\Http\Controllers;

use App\Http\Requests\SaveChallengeRequest;
use App\Models\Challenge;
use App\Models\ChallengeCategory;
use App\Models\ChallengeUser;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cookie;
use JamesDordoy\LaravelVueDatatable\Http\Resources\DataTableCollectionResource;
class ChallengeController extends Controller
{
    public function __construct()
    {
        if (Cookie::get('token') != null) {
            $this->middleware(['header_api','auth:api']);
        }
    }
    // all challenges
    public function challenges()
    {
        $challenges= Challenge::all();
        $challenges->load('category');
        return response()->json([
            'status'=>'success',
            'messege' => 'Succsess get list challenges',
            'data' => $challenges,
        ], 200);
    }
    public function index(Request $request)
    {
        $query = Challenge::eloquentQuery(
            $request->input('column'),
            $request->input('dir'),
            $request->input('search'),
            [
                "category",
            ]
        );
        
        $data = $query->paginate($request->input('length'));
        return new DataTableCollectionResource($data);
    }
    // add challenge
    public function create(SaveChallengeRequest $request)
    {
        $rule= [
            'image' => 'required|image',
            'resources' => 'required|file'
          ];
          $messages = [
              'image.required' => "Hãy chọn file ảnh.",
              'resources.required' => "Hãy chọn tài nguyên.",
              'resources.file' => "Phải là một tập tin.",
              'image.image' => "Phải là một hình ảnh.",
          ];
     
          $validator =  Validator::make($request->all(),$rule,$messages);
            if ($validator->fails()) { 
              return response()->json(['errors'=>$validator->errors()],422);
            }
        $slug = Str::slug($request->title,'-');
        $c = Challenge::where('slug','=', $slug)->first();
        if($c){
            $slug = $slug.Str::random(5);
        }
        if($request->hasFile('image')){
            $image = time().'-'.$request->image->getClientOriginalName();
            $request->image->move(public_path('files'),$image);
            $imageName = 'files/'.$image;
         }
        if($request->hasFile('resources')){
            $sources = time().'-'.$request->resources->getClientOriginalName();
            $request->resources->move(public_path('files'),$sources);
            $resources = 'files/'.$sources;
         }
        $challenge = new Challenge([
            'title' => $request->title,
            'slug' =>$slug,
            'description' => $request->description,
            'language' => $request->language,
            'link_figma' => $request->link_figma,
            'design_on_figma' => $request->design_on_figma,
            'image'=>$imageName,
            'resources'=>$resources,
            'level' => $request->level,
            'cate_challen_id' => $request->cate_challen_id,
        ]);
        $challenge->save();

        return response()->json(['status'=>'success','message'=>'The challenge successfully added','data'=>$challenge],201);
    }

    // edit challenge
    public function show($id)
    {
        $challenge = Challenge::find($id);
        $challenge['Onechallengecategory'] = ChallengeCategory::where('id',$challenge->cate_challen_id )->first();
        $challenge['challengecategory'] = ChallengeCategory::all();
        return response()->json(['status'=>'success','message'=>'Success get challenge','data'=>$challenge],200);
    }

    // update challenge
    public function update($id, SaveChallengeRequest $request)
    {
        $challenge = Challenge::find($id);
        $imageName = $challenge->image;
        $resources = $challenge->resources;
        if($request->hasFile('image')){
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
           $image = time().'-'.$request->image->getClientOriginalName();
           $request->image->move(public_path('files'),$image);
           $imageName = 'files/'.$image;
           File::delete($challenge->image);
        }
        if($request->hasFile('resources')){
            $rule= [
                'resources' => 'file',
              ];
              $messages = [
                  'resources.file' => "Phải là một tập tin.",
              ];
         
            $validator =  Validator::make($request->all(),$rule,$messages);
            if ($validator->fails()) { 
                return response()->json(['errors'=>$validator->errors()],422);
            }
           $sources = time().'-'.$request->resources->getClientOriginalName();
           $request->resources->move(public_path('files'),$sources);
           $resources = 'files/'.$sources;
            File::delete($challenge->resources);
        }
        $slug = Str::slug($request->title,'-');
        $c = Challenge::where('slug', $slug)
                     ->where('id','!=',$request->id)
                     ->first();
        if($c){
            $slug = $slug. Str::random(5);
        }
        $challenge->title = $request->title;
        $challenge->slug = $slug;
        $challenge->image = $imageName;
        $challenge->resources = $resources;
        $challenge->description = $request->description;
        $challenge->language = $request->language;
        $challenge->link_figma = $request->link_figma;
        $challenge->design_on_figma = $request->design_on_figma;
        $challenge->cate_challen_id = $request->cate_challen_id;
        $challenge->level = $request->level;
        $challenge->save();
        return response()->json(['status'=>'success','message'=>'The challenge successfully updated','data'=>$challenge],200);
    }

    // delete challenge
    public function delete($id)
    {
        $challenge = Challenge::find($id);
        File::delete($challenge->image,$challenge->resources);
        $challenge->delete();

        return response()->json(['status'=>'success','message'=>'The challenge successfully deleted'],200);
    }
    public function deleteMultiple(Request $request)
    {
       foreach ($request->challenge_id as $id ) {
        $challenge = Challenge::find($id);
        File::delete($challenge->image,$challenge->resources);
        $challenge->delete();
       }
        return response()->json([
            'status'=>'success',
            'messege' => 'Succsess delete user',
        ], 200);
    }
    // show one challenge
    public function get_One_Challenge($slug)
    {
        $challenge =  Challenge::where('slug','=', $slug)->first();
        $challenge->load('category');
        return response()->json(['status'=>'success','message'=>'Success get challenge','data'=>$challenge],200);
    }
    
    public function challUser($id)
    {
        $challenge_user = new ChallengeUser([
            'challen_id'=> $id,
            'user_id'=> Auth::id(),
            'status' => 0
        ]);
        $challenge_user->save();
        return response()->json(['status'=>'success','message'=>'Success get challenge_user','data'=>true],201);
    }
    public function checkChallUser($slug)
    {
        $chall =  Challenge::where('slug','=', $slug)->first();
        $challenge =  ChallengeUser::where('challen_id','=', $chall->id)->where('user_id','=',Auth::id())->first();
        if($challenge){
            $check=true;
        }else{
            $check=false;  
        }
        return response()->json(['status'=>'success','message'=>'Success get challenge','data'=>$check],200);
    }
}
