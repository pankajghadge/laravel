<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateVolumesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('volumes', function (Blueprint $table) {
            $table->increments('id');
	    $table->mediumInteger('size')->unsigned();
	    $table->string('device')->nullable();
	    $table->string('mount_folder')->nullable();
	    $table->string('filesystem')->nullable();

            $table->string('region')->nullable();
            $table->string('availability_zone')->nullable();

	    $table->integer('server_id')->unsigned();
	    $table->foreign('server_id')->references('id')->on('servers')->nullable();

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
        Schema::dropIfExists('volumes');
    }
}
