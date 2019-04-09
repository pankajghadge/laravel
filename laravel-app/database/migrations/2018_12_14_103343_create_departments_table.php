<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateDepartmentsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('departments', function (Blueprint $table) {
            $table->increments('id');
	    $table->string('name');
	    $table->integer('number')->unsigned()->nullable();
	    $table->integer('instance_quota')->unsigned()->default(5);
	    $table->integer('core_quota')->unsigned()->default(10);
	    $table->integer('memory_quota')->unsigned()->default(50);
	    $table->integer('volume_quota')->unsigned()->default(5);
	    $table->integer('gigabyte_quota')->unsigned()->default(1000);
            $table->text('description')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('departments');
    }
}
