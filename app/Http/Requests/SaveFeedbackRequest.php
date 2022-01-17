<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
class SaveFeedbackRequest extends FormRequest
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
            'feedback_content' => [
                'required',
                'min:2',
            ],
        ];
    }

    public function messages()
    {
        return [
            'feedback_content.required' => "Hãy nhập nội dung",
            'feedback_content.min' => "Ít nhất có 2 ký tự",
        ];
    }
}
