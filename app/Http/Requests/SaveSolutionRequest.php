<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class SaveSolutionRequest extends FormRequest
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
            'title' => [
                'required',
                'min:2'
            ],
            'description' => ['required','min:4'],
            'challen_id' => ['required'],
            'link_github' => ['required',
            Rule::unique('solutions')->ignore($this->id)],
            'demo_url' => ['required',
            Rule::unique('solutions')->ignore($this->id)],
        ];
    }

    public function messages()
    {
        return [
            'title.required' => "Hãy nhập tên giải pháp",
            'title.min' => "Ít nhất có 2 ký tự",
            'challen_id.required' => "Hãy chọn thử thách",
            'link_github.required' => "Hãy nhập link github",
            'link_github.unique' => "Link github đã tồn tại",
            'demo_url.required' => "Hãy nhập link demo",
            'demo_url.unique' => "Link demo đã tồn tại",
            'description.required' => "Hãy nhập mô tả",
            'description.min' => "Ít nhất có 2 ký tự",
        ];
    }
}
