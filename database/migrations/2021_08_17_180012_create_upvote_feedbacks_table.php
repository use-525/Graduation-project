<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUpvoteFeedbacksTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('upvote_feedbacks', function (Blueprint $table) {
            $table->integer('user_id')->unsigned();
            $table->integer('feedback_id')->unsigned();
            $table->timestamps();
            $table->primary(['user_id', 'feedback_id']);
            $table->foreign('feedback_id')->references('id')->on('feedbacks')->onUpdate('cascade')->onDelete('cascade');
            $table->foreign('user_id')->references('id')->on('users')->onUpdate('cascade')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('upvote_feedbacks');
    }
}
