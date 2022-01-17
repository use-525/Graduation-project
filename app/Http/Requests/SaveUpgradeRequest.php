<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class SaveUpgradeRequest extends FormRequest
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
            'name' => ['required','min:4',Rule::unique('upgrades')->ignore($this->id)],
            'description' => ['required','min:4'],
            'price' => ['required','numeric','min:0','max:99999999999999'],
            'period'=>['required'],
        ];
    }

    public function messages()
    {
        return [
            'name.required' => "Hãy nhập tên",
            'name.min' => "Ít nhất có 4 ký tự",
            'name.unique' => "Tên gói đã tồn tại",
            'description.required' => "Hãy nhập mô tả",
            'description.min' => "Ít nhất có 4 ký tự",
            'period.required' => "Hãy nhập thời hạn",
            'price.numeric' => "Không đúng định dạng",
            'price.min' => "Nhập số từ 0 đến 99999999999999",
            'price.max' => "Nhập số từ 0 đến 99999999999999",
            'price.required' => "Hãy nhập giá",
        ];
    }
}
