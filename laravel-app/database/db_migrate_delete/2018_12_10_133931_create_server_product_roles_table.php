<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateServerProductRolesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('server_product_roles', function (Blueprint $table) {
	    $table->foreign('server_id')->references('id')->on('servers');
	    $table->foreign('product_version_id')->references('id')->on('product_versions');
	    $table->foreign('configuration_service_id')->references('id')->on('configuration_services');
	    $table->longText('config_data')->nullable();
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
        Schema::dropIfExists('server_product_roles');
    }
}
