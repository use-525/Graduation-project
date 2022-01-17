<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;
use App\Models\Order;
use App\Models\Upgrade;
use Carbon\Carbon;

class OmnipayController extends Controller
{
    public function __construct()
    {
        $this->middleware(['header_api', 'auth:api']);
    }
    //Tạo yêu cầu thanh toán
    public function purchase($upgrade_id)
    {

        $latestOrder = Order::orderBy('created_at', 'DESC')->first();
        $order_id = $latestOrder->id ?? 1;
        $upgrade = Upgrade::find($upgrade_id);
        $period = $upgrade->period ?? 0;
        $order = new Order([
            'order_nr' => strtoupper(date('dmy') . $order_id . Str::random(5)),
            'upgrade_id' => $upgrade_id,
            'user_id' => Auth::id(),
            'amount' => $upgrade->price,
            'status' => 0,
            'expiration' => Carbon::now()->addMonths($period),
        ]);
        $order->save();
        $redirectUrl = 'https://momosv3.apimienphi.com/api/QRCode?phone=' . env('PHONE_MOMO') . '&amount=' . $upgrade->price . '&note=Kích_Hoạt_Tài_Khoản:' . Auth::id();
        // return redirect($redirectUrl);
        // TODO: chuyển khách sang trang MoMo để thanh toán
        return response()->json(['status' => 'success', 'message' => 'Succsess get order', 'data' => $redirectUrl], 200);
    }
}
