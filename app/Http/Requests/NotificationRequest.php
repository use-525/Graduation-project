<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class NotificationRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'content' => ['required','min:4'],
            'title' => ['required','min:4'],
            'user_id' => ['required'],
        ];
    }

    public function messages()
    {
        return [
            'user_id.required' => "Hãy nhập tên người nhận",
            'content.required' => "Hãy nhập nội dung",
            'content.min' => "Ít nhất có 2 ký tự",
            'title.required' => "Hãy nhập tiêu đề",
            'title.min' => "Ít nhất có 2 ký tự",
        ];
    }
}
