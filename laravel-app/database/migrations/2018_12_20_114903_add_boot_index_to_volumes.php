<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddBootIndexToVolumes extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('volumes', function (Blueprint $table) {
	    #$table->enum('source_type', ['image', 'snapshot', 'volume', 'blank'])->before('device_type');
	    #$table->enum('destination_type', ['volume', 'local'])->after('source_type');
	    $table->smallInteger('boot_index')->after('device')->nullable();
	    $table->boolean('delete_on_termination')->after('boot_index')->default(false);
	    $table->string('guest_format')->before('device')->nullable();
            $table->renameColumn('device', 'device_type');

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('volumes', function (Blueprint $table) {
            //
        });
    }
}
