/**
 * Created by JetBrains RubyMine.
 * User: gregor
 * Date: 12/2/25
 * Time: 13:05
 * To change this template use File | Settings | File Templates.
 */

function encode_query_data(data) {
    var ret = [];
    for (var d in data)
        ret.push(encodeURIComponent(d) + "=" + encodeURIComponent(data[d]));
    return ret.join("&");
}

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

map_task_to_employee = function (employee_name, task_name, workload, quantity, success_handler, error_handler) {
    $.ajax({
        type:"POST",
        url:"/api/map/task/" + employee_name + "/" + task_name,
        data:$.toJSON({
            "workload":workload,
            "quantity":quantity
        }),
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
        url:"/api/map/working/" + employee_name,
        data:$.toJSON({
            "working":working
        }),
        success:success_handler,
        error:error_handler
    });
};

set_value_for_task = function (task_name, value_name, value, success_handler, error_handler) {
    $.ajax({
        type:"POST",
        url:"/api/task/" + task_name + "/" + value_name,
        data:$.toJSON({
            "value":value
        }),
        success:success_handler,
        error:error_handler
    });
};
