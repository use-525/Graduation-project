<?php

use App\Http\Controllers\UserController;
use App\Http\Controllers\RoleController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\ChallengeCategoryController;
use App\Http\Controllers\ChallengeController;
use App\Http\Controllers\PermissionController;
use App\Http\Controllers\FeedbackController;
use App\Http\Controllers\SolutionController;
use App\Http\Controllers\ChatController;
use App\Http\Controllers\NotificationController;
use App\Http\Controllers\OmnipayController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\UpgradeController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
Route::middleware('auth:api')->group(function() {
    Route::get('/logout', [AuthController::class,'logout'])->name('logout');
    Route::get('/user', [AuthController::class, 'user'])->name('me');
   
});
Route::group(['middleware' => 'api'], function () {
    Route::post('/login', [AuthController::class, 'login'])->name('login');
    Route::post('/register', [AuthController::class, 'register'])->name('register');
   
});

// Route::group(['middleware' => 'auth:api'], function () {
//     Route::post('logout', [LoginController::class, 'logout']);

//     Route::get('user', [UserController::class, 'current']);
// });
Route::post('change-password/{id}',[UserController::class, 'changePass'])->name('change.password');
Route::post('create-password/{id}',[UserController::class, 'createPass'])->name('create.password');
Route::get('mentors', [UserController::class, 'mentors'])->name('mentors');
Route::get('chat-user', [UserController::class, 'chatUser'])->name('chat.user');
Route::get('users', [UserController::class, 'index'])->name('users');
Route::group(['prefix' => 'user'], function () {
    Route::post('add', [UserController::class, 'create'])->name('create.user');
    Route::get('all', [UserController::class, 'users'])->name('all.user');
    Route::get('chart', [UserController::class, 'chartUser'])->name('chart.user');
    Route::post('delete-multiple', [UserController::class, 'deleteMultiple'])->name('multiple.users');
    Route::get('{id}', [UserController::class, 'show'])->name('show.user');
    Route::post('update/{id}', [UserController::class, 'update'])->name('update.user');
    Route::post('profile/{id}', [UserController::class, 'profile'])->name('profile.user');
    Route::delete('delete/{id}', [UserController::class, 'delete'])->name('delete.user');
});

Route::get('roles', [RoleController::class, 'index'])->name('roles');
Route::group(['prefix' => 'role'], function () {
    Route::post('add', [RoleController::class, 'create'])->name('create.role');
    Route::get('all', [RoleController::class, 'roles'])->name('all.role');
    Route::post('delete-multiple', [RoleController::class, 'deleteMultiple'])->name('multiple.roles');
    Route::get('{id}', [RoleController::class, 'show'])->name('show.role');
    Route::post('update/{id}', [RoleController::class, 'update'])->name('update.role');
    Route::delete('delete/{id}', [RoleController::class, 'delete'])->name('delete.role');
});

Route::get('permissions', [PermissionController::class, 'index'])->name('permissions');
Route::group(['prefix' => 'permission'], function () {
    Route::post('add', [PermissionController::class, 'create'])->name('create.permission');
    Route::get('all', [PermissionController::class, 'permissions'])->name('all.permission');
    Route::post('delete-multiple', [PermissionController::class, 'deleteMultiple'])->name('multiple.permissions');
    Route::get('{id}', [PermissionController::class, 'show'])->name('show.permission');
    Route::post('update/{id}', [PermissionController::class, 'update'])->name('update.permission');
    Route::delete('delete/{id}', [PermissionController::class, 'delete'])->name('delete.permission');
});

Route::get('challengecategories', [ChallengeCategoryController::class, 'index'])->name('challengecategories');
Route::get('get_All_Challenge_Category', [ChallengeCategoryController::class, 'get_All_Challenge_Category'])->name('get_All.challengecategory');
Route::get('get_One_Challenge_Category/{slug}', [ChallengeCategoryController::class, 'get_One_Challenge_Category'])->name('get_One.challengecategory');
Route::get('get-one-by-slug/{slug}', [ChallengeCategoryController::class, 'getOneBySlug'])->name('bySlug.challengecategory');
Route::get('get-one-by-chall/{slug}', [ChallengeCategoryController::class, 'getCategoryByChall'])->name('bySlugChall.challengecategory');
Route::group(['prefix' => 'challengecategory'], function () {
    Route::middleware(['header_api', 'auth:api'])->post('add', [ChallengeCategoryController::class, 'create'])->name('create.challengecategory');
    Route::get('all', [ChallengeCategoryController::class, 'categories'])->name('all.challengecategory');
    Route::get('chart', [ChallengeCategoryController::class, 'handleChart'])->name('chart.challengecategory');
    Route::middleware(['header_api', 'auth:api'])->post('delete-multiple', [ChallengeCategoryController::class, 'deleteMultiple'])->name('multiple.categories');
    Route::get('{id}', [ChallengeCategoryController::class, 'show'])->name('show.challengecategory');
    Route::middleware(['header_api', 'auth:api'])->post('update/{id}', [ChallengeCategoryController::class, 'update'])->name('update.challengecategory');
    Route::middleware(['header_api', 'auth:api'])->delete('delete/{id}', [ChallengeCategoryController::class, 'delete'])->name('delete.challengecategory');
});

Route::get('challenges', [ChallengeController::class, 'index'])->name('challenges');
Route::get('get_One_Challenge/{slug}', [ChallengeController::class, 'get_One_Challenge'])->name('get_One.challenge');
Route::group(['prefix' => 'challenge'], function () {
    Route::middleware(['header_api', 'auth:api'])->post('add', [ChallengeController::class, 'create'])->name('create.challenge');
    Route::get('all', [ChallengeController::class, 'challenges'])->name('all.challenge');
    Route::middleware(['header_api', 'auth:api'])->post('delete-multiple', [ChallengeController::class, 'deleteMultiple'])->name('multiple.challenges');
    Route::get('{id}', [ChallengeController::class, 'show'])->name('show.challenge');
    Route::middleware(['header_api', 'auth:api'])->post('update/{id}', [ChallengeController::class, 'update'])->name('update.challenge');
    Route::middleware(['header_api', 'auth:api'])->delete('delete/{id}', [ChallengeController::class, 'delete'])->name('delete.challenge');
    Route::post('challUser/{id}', [ChallengeController::class, 'challUser'])->name('challUser.challenge');
    Route::get('check/{slug}', [ChallengeController::class, 'checkChallUser'])->name('check.challenge');
});

Route::get('solutions', [SolutionController::class, 'index'])->name('solutions');
Route::get('category-solutions/{slug}', [SolutionController::class, 'categorySolution'])->name('categorySolutions');
Route::get('detail-solution/{id}', [SolutionController::class, 'detailSolution'])->name('detailSolution');
Route::get('portfolio/{username}', [SolutionController::class, 'portfolio'])->name('portfolio');
Route::group(['prefix' => 'solution'], function () {
    Route::middleware(['header_api', 'auth:api'])->post('add', [SolutionController::class, 'create'])->name('create.solution');
    Route::get('all', [SolutionController::class, 'solutions'])->name('all.solution');
    Route::get('challenge-user', [SolutionController::class, 'challengeUser'])->name('challengeUser.solution');
    Route::middleware(['header_api', 'auth:api'])->post('delete-multiple', [SolutionController::class, 'deleteMultiple'])->name('multiple.solutions');
    Route::get('{id}', [SolutionController::class, 'show'])->name('show.solution');
    Route::middleware(['header_api', 'auth:api'])->post('update/{id}', [SolutionController::class, 'update'])->name('update.solution');
    Route::middleware(['header_api', 'auth:api'])->delete('delete/{id}', [SolutionController::class, 'delete'])->name('delete.solution');
    Route::get('check-solution/{slug}', [SolutionController::class, 'checkSolutionChall'])->name('check.solution');
    Route::middleware(['header_api', 'auth:api'])->post('edit-solution/{slug}', [SolutionController::class, 'editSolutionChall'])->name('edit.solution');
    Route::middleware(['header_api', 'auth:api'])->post('upvote/{id}', [SolutionController::class, 'upvote'])->name('upvote.solution');
    Route::get('check-vote/{id}', [SolutionController::class, 'checkUpvote'])->name('checkUpvote.solution');
});


Route::get('feedbacks', [FeedbackController::class, 'index'])->name('feedbacks');
Route::get('category-feedback/{slug}', [FeedbackController::class, 'feedbackGetByCate'])->name('feedback.byCate');
Route::group(['prefix' => 'feedback'], function () {
    Route::middleware('auth:api')->post('add/{parent_id}/{solution_id}', [FeedbackController::class, 'create'])->name('create.feedback');
    Route::get('all', [FeedbackController::class, 'feedbacks'])->name('all.feedback');
    Route::middleware(['header_api', 'auth:api'])->post('delete-multiple', [FeedbackController::class, 'deleteMultiple'])->name('multiple.feedbacks');
    Route::get('solution-feedback/{solution_id}', [FeedbackController::class, 'solutionFeedbackTable'])->name('solution.feedback');
    Route::get('solutions/{solution_id}', [FeedbackController::class, 'feedbackSolutions'])->name('solutionFeedback.feedback');
    Route::middleware(['header_api', 'auth:api'])->post('update-approved/{id}', [FeedbackController::class, 'updateApproved'])->name('approved.feedback');
    Route::get('{id}', [FeedbackController::class, 'show'])->name('show.feedback');
    Route::middleware(['header_api', 'auth:api'])->post('update/{id}', [FeedbackController::class, 'update'])->name('update.feedback');
    Route::middleware(['header_api', 'auth:api'])->delete('delete/{id}', [FeedbackController::class, 'delete'])->name('delete.feedback');
    Route::middleware(['header_api', 'auth:api'])->post('upvote/{id}', [FeedbackController::class, 'upvote'])->name('upvote.feedback');
});

Route::prefix('chat')->middleware('auth:api')->group(function() {
    Route::get('rooms', [ChatController::class, 'rooms'])->name('rooms');
    Route::get('room/{roomID}/messages', [ChatController::class, 'messages'])->name('messages');
    Route::post('room/{roomID}/message', [ChatController::class, 'newMessage'])->name('newMessage');
    Route::get('/private-messages/{id}', [ChatController::class, 'privateMessages'])->name('privateMessages');
    Route::post('/private-messages/{id}', [ChatController::class, 'sendPrivateMessage'])->name('privateMessages.store');
});

Route::get('orders', [OrderController::class, 'index'])->name('orders');
Route::prefix('order')->group(function() {
    Route::post('purchase/{upgrade_id}', [OmnipayController::class, 'purchase'])->name('order.purchase');
    Route::any('complete-purchase', [OmnipayController::class, 'completePurchase'])->name('completePurchase');
    Route::any('notification', [OmnipayController::class, 'notification'])->name('order.notification');
    Route::get('/query-transaction', [OmnipayController::class, 'queryTransaction'])->name('queryTransaction');
    Route::get('all', [OrderController::class, 'orders'])->name('all.order');
    Route::post('add', [OrderController::class, 'create'])->name('create.order');
    Route::get('chart', [OrderController::class, 'handleChart'])->name('chart.order');
    Route::post('delete-multiple', [OrderController::class, 'deleteMultiple'])->name('multiple.orders');
    Route::get('{id}', [OrderController::class, 'show'])->name('show.order');
    Route::post('update/{id}', [OrderController::class, 'update'])->name('update.order');
    Route::delete('delete/{id}', [OrderController::class, 'delete'])->name('delete.order');
});

Route::get('upgrades', [UpgradeController::class, 'index'])->name('upgrades');
Route::prefix('upgrade')->group(function() {
    Route::get('all', [UpgradeController::class, 'upgrades'])->name('all.upgrade');
    Route::middleware(['header_api', 'auth:api'])->post('add', [UpgradeController::class, 'create'])->name('create.upgrade');
    Route::middleware(['header_api', 'auth:api'])->post('delete-multiple', [UpgradeController::class, 'deleteMultiple'])->name('multiple.upgrades');
    Route::middleware(['header_api', 'auth:api'])->get('{id}', [UpgradeController::class, 'show'])->name('show.upgrade');
    Route::middleware(['header_api', 'auth:api'])->post('update/{id}', [UpgradeController::class, 'update'])->name('update.upgrade');
    Route::middleware(['header_api', 'auth:api'])->delete('delete/{id}', [UpgradeController::class, 'delete'])->name('delete.upgrade');
});

Route::get('notifications', [NotificationController::class, 'index'])->name('notifications');
Route::prefix('notification')->group(function() {
    Route::post('add', [NotificationController::class, 'create'])->name('create.notification');
    Route::get('by-user', [NotificationController::class, 'notificationByUser'])->name('byUser.notification');
    Route::post('delete-multiple', [NotificationController::class, 'deleteMultiple'])->name('multiple.notifications');
    Route::get('{id}', [NotificationController::class, 'show'])->name('show.notification');
    Route::post('read/{id}', [NotificationController::class, 'markAsRead'])->name('markAsRead.notification');
    Route::post('update/{id}', [NotificationController::class, 'update'])->name('update.notification');
    Route::delete('delete/{id}', [NotificationController::class, 'delete'])->name('delete.notification');
});

Route::post('forgot-pass',[AuthController::class,'postForgot'])->name('user.forgot_pass');
Route::get('/reset-password/{token}', [AuthController::class,'checkTokenResset'])->middleware('guest')->name('password.reset');

Route::post('/reset-password', [AuthController::class,'resetPass'])
        ->middleware('guest')->name('password.update');

Route::get('/search-private/{search}', [ChatController::class,'searchPrivate'])->name('search.private');
Route::get('/search-room/{search}', [ChatController::class,'searchGroup'])->name('search.room');
Route::middleware(['header_api', 'auth:api'])->get('export-users', [UserController::class,'export'])->name('export.users');