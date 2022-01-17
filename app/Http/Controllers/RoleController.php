<?php

namespace App\Http\Controllers;

use App\Http\Requests\SaveRoleRequest;
use App\Models\Permission;
use App\Models\Role;
use App\Models\RoleHasPermission;
use Illuminate\Http\Request;
use JamesDordoy\LaravelVueDatatable\Http\Resources\DataTableCollectionResource;

class RoleController extends Controller
{
    public function __construct()
    {
        $this->middleware(['header_api', 'auth:api']);
    }
    // all roles
     public function roles()
     {
        return response()->json([
            'status'=>'success',
            'messege' => 'Succsess get list roles',
            'data' => Role::all(),
        ], 200);
     }
 
    public function index(Request $request)
    {   
        $query = Role::eloquentQuery(
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

     // add role
     public function create(SaveRoleRequest $request)
     {
         $role = new Role([
             'name' => $request->name,
            'guard_name'=>'api'
         ]);
         $role->save();
        foreach ($request->permission_id as $id) {
            $role_has_permission = new RoleHasPermission([
                'permission_id' => $id,
                'role_id'=> $role->id
            ]);
            $role_has_permission->save();
        }
         return response()->json(['status'=>'success','message'=>'The role successfully added','data'=>$role],201);
     }
 
     // edit role
     public function show($id)
     {
         $data=[];
         $data['role'] = Role::find($id);
         $data['role']->load('roleHasPermissions');
         $data['permissions'] = Permission::all();
         return response()->json(['status'=>'success','message'=>'Succsess get role','data'=>$data],200);
     }
 
     // update role
     public function update($id, SaveRoleRequest $request)
     {
         $role = Role::find($id);
         $role->update($request->all());
         RoleHasPermission::where('role_id',$id)->delete();
         foreach ($request->permission_id as $id) {
            $role_has_permission = new RoleHasPermission([
                'permission_id' => $id,
                'role_id'=> $role->id
            ]);
            $role_has_permission->save();
        }
         return response()->json(['status'=>'success','message'=>'The role successfully updated','data'=>$role],200);
     }
 
     // delete role
     public function delete($id)
     {
         $role = Role::find($id);
         $role->delete();
 
         return response()->json(['status'=>'success','message'=>'The role successfully deleted'],200);
     }
     public function deleteMultiple(Request $request)
     {
        foreach ($request->role_id as $id ) {
            $role = Role::find($id);
            $role->delete();
        }
         return response()->json([
             'status'=>'success',
             'messege' => 'Succsess delete user',
         ], 200);
     }
}
