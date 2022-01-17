<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;
use Spatie\Permission\PermissionRegistrar;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
class PermissionsSeeder extends Seeder
{
   /**
* Create the initial roles and permissions.
*
* @return void
*/
public function run()
    {
    // Reset cached roles and permissions
    app()[PermissionRegistrar::class]->forgetCachedPermissions();

    // create permissions
    Permission::create(['name' => 'edit challenges']);
    Permission::create(['name' => 'delete challenges']);
    Permission::create(['name' => 'publish challenges']);
    Permission::create(['name' => 'unpublish challenges']);
    Permission::create(['name' => 'edit categories']);
    Permission::create(['name' => 'delete categories']);
    Permission::create(['name' => 'publish categories']);
    Permission::create(['name' => 'login admin']);

    // create roles and assign existing permissions
    $role1 = Role::create(['name' => 'writer']);
    $role1->givePermissionTo('edit challenges');
    $role1->givePermissionTo('delete challenges');

    $role2 = Role::create(['name' => 'admin']);
    $role2->givePermissionTo('publish challenges');
    $role2->givePermissionTo('unpublish challenges');

    $role3 = Role::create(['name' => 'super-admin']);
    // gets all permissions via Gate::before rule; see AuthServiceProvider

    // create demo users
    // $user = new User();
    // $user->username = 'write';
    // $user->email = 'dev_full@test.com';
    // $user->password = Hash::make('secret');
    // $user->save();
    // $user->assignRole($role1);

    // $user = new User();
    // $user->username = 'admin';
    // $user->email = 'admin123@test.com';
    // $user->password = Hash::make('secret');
    // $user->save();
    // $user->assignRole($role2);

    // $user = new User();
    // $user->username = 'super';
    // $user->email = 'superadmin@test.com';
    // $user->password = Hash::make('secret');
    // $user->save();
    // $user->assignRole($role3);
    }
}
