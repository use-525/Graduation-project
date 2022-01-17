<?php

namespace App\Exports;

use App\Models\User;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;

class UsersExport implements FromCollection,WithHeadings
{
    public function headings():array    
    {
        return [
            'Id',
            'Tên tài khoản',
            'Địa chỉ email',
            'Họ tên',
            'Số điện thoại',
            'Link github',
            'Địa chỉ',
            'Hình ảnh',
            'Giới tính',
            'Vai trò',
            'Ngày tham gia',
        ];
    }
   
    /**
    * @return \Illuminate\Support\Collection
    */
    public function collection()
    {
        $users = User::all();
        $users->load('roles');
        foreach ($users as $row) {
            $post[] = array(
                '0' => $row->id,
                '1' => $row->username,
                '2' => $row->email,
                '3' => $row->name,
                '4' => $row->phone,
                '5' => $row->github_url,
                '6' => $row->address,
                '7' => asset($row->image),
                '8' => $row->gender==1?'Nam':'Nữ',
                '9' => $row->roles[0]->name,
                '10' => $row->created_at,
            );
        }

        return (collect($post));
    }
}
