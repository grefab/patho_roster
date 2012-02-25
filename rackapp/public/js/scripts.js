/**
 * Created by JetBrains RubyMine.
 * User: gregor
 * Date: 12/2/25
 * Time: 13:05
 * To change this template use File | Settings | File Templates.
 */

add_employee = function (employee_name, success_handler, error_handler) {
    $.ajax({
        type:"PUT",
        url:"/api/employee/" + employee_name,
        success:success_handler,
        error:error_handler
    });
};

del_employee = function (employee_name, success_handler, error_handler) {
    $.ajax({
        type:"DELETE",
        url:"/api/employee/" + employee_name,
        success:success_handler,
        error:error_handler
    });
};

map_task_to_employee = function (employee_name, task_name, workload, success_handler, error_handler) {
    $.ajax({
        type:"POST",
        url:"/api/map/task/" + employee_name + "/" + task_name + "/" + workload,
        success:success_handler,
        error:error_handler
    });
};

del_task_from_employee = function (employee_name, task_name, success_handler, error_handler) {
    $.ajax({
        type:"DELETE",
        url:"/api/map/task/" + employee_name + "/" + task_name,
        success:success_handler,
        error:error_handler
    });
};

set_working_for_employee = function (employee_name, working, success_handler, error_handler) {
    $.ajax({
        type:"POST",
        url:"/api/map/working/" + employee_name + "/" + working,
        success:success_handler,
        error:error_handler
    });
};

set_value_for_task = function (task_name, value_name, value, success_handler, error_handler) {
    $.ajax({
        type:"POST",
        url:"/api/task/" + task_name + "/" + value_name + "/" + value,
        success:success_handler,
        error:error_handler
    });
};