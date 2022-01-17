<?php

namespace App\Http\Controllers;

use App\Http\Requests\SavePermissionRequest;
use App\Models\Permission;
use Illuminate\Http\Request;
use JamesDordoy\LaravelVueDatatable\Http\Resources\DataTableCollectionResource;

class PermissionController extends Controller
{
    public function __construct()
    {
        $this->middleware(['header_api', 'auth:api']);
    }
    // all permissions
    public function permissions()
    {
       return response()->json([
           'status'=>'success',
           'messege' => 'Succsess get list permissions',
           'data' => Permission::all(),
       ], 200);
    }

    public function index(Request $request)
    {   
        $length = $request->input('length');
        $sortBy = $request->input('column');
        $orderBy = $request->input('dir');
        $searchValue = $request->input('search');
        
        $query = Permission::eloquentQuery($sortBy, $orderBy, $searchValue);

        $data = $query->paginate($length);
        
        return new DataTableCollectionResource($data);
    }
    // add permission
    public function create(SavePermissionRequest $request)
    {
        $permission = new Permission([
            'name' => $request->name,
            'guard_name'=>'api'
        ]);
        $permission->save();

        return response()->json(['status'=>'success','message'=>'The permission successfully added','data'=>$permission],201);
    }

    // edit permission
    public function show($id)
    {
        $permission = Permission::find($id);
        return response()->json(['status'=>'success','message'=>'Succsess get permission','data'=>$permission],200);
    }

    // update permission
    public function update($id, SavePermissionRequest $request)
    {
        $permission = Permission::find($id);
        $permission->update($request->all());

        return response()->json(['status'=>'success','message'=>'The permission successfully updated','data'=>$permission],200);
    }

    // delete permission
    public function delete($id)
    {
        $permission = Permission::find($id);
        $permission->delete();

        return response()->json(['status'=>'success','message'=>'The permission successfully deleted'],200);
    }
    public function deleteMultiple(Request $request)
    {
       foreach ($request->permission_id as $id ) {
        $permission = Permission::find($id);
        $permission->delete();
       }
        return response()->json([
            'status'=>'success',
            'messege' => 'Succsess delete user',
        ], 200);
    }
}
