<?php

namespace App\Http\Controllers;

use App\Http\Requests\SaveUpgradeRequest;
use App\Models\Upgrade;
use Illuminate\Http\Request;
use JamesDordoy\LaravelVueDatatable\Http\Resources\DataTableCollectionResource;

class UpgradeController extends Controller
{
    // all upgrades
    public function upgrades()
    {
        return response()->json([
            'status'=>'success',
            'messege' => 'Succsess get list upgrades',
            'data' => Upgrade::all(),
        ], 200);
    }

    public function index(Request $request)
    {
        $length = $request->input('length');
        $sortBy = $request->input('column');
        $orderBy = $request->input('dir');
        $searchValue = $request->input('search');
        
        $query = Upgrade::eloquentQuery($sortBy, $orderBy, $searchValue);

        $data = $query->paginate($length);
        
        return new DataTableCollectionResource($data);
    }
     // add upgrade
     public function create(SaveUpgradeRequest $request)
     {
         $upgrade = new Upgrade([
             'name' => $request->name,
             'description'=>$request->description,
             'price'=>$request->price,
             'period'=>$request->period,
         ]);
         $upgrade->save();
 
         return response()->json(['status'=>'success','message'=>'The upgrade successfully added','data'=>$upgrade],201);
     }
 
     // edit upgrade
     public function show($id)
     {
         $upgrade = Upgrade::find($id);
         return response()->json(['status'=>'success','message'=>'Succsess get upgrade','data'=>$upgrade],200);
     }
 
     // update upgrade
     public function update($id, SaveUpgradeRequest $request)
     {
         $upgrade = Upgrade::find($id);
         $upgrade->update($request->all());
 
         return response()->json(['status'=>'success','message'=>'The upgrade successfully updated','data'=>$upgrade],200);
     }
 
     // delete upgrade
     public function delete($id)
     { 
         $upgrade = Upgrade::find($id);
         $upgrade->delete();
 
         return response()->json(['status'=>'success','message'=>'The upgrade successfully deleted'],200);
     }
     public function deleteMultiple(Request $request)
     {
        foreach ($request->upgrade_id as $id ) {
            $upgrade = Upgrade::find($id);
            $upgrade->delete();
        }
         return response()->json([
             'status'=>'success',
             'messege' => 'Succsess delete user',
         ], 200);
     }
}
