<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateProductVersionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('product_versions', function (Blueprint $table) {
            $table->increments('id');
	    $table->foreign('product_id')->references('id')->on('products')->onDelete('cascade');
	    $table->string('value');
	    $table->longText('salt_config_data')->nullable();
	    $table->longText('ansible_config_data')->nullable();
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
        Schema::dropIfExists('product_versions');
    }
}
