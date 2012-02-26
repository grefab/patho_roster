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

set_working_for_employee = function (employee_name, working, success_handler, error_handler) {
    $.ajax({
        type:"POST",
        url:"/api/employee/" + employee_name,
        data:$.toJSON({
            "working":working
        }),
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


map_workload = function (employee_name, task_name, workload, success_handler, error_handler) {
    $.ajax({
        type:"POST",
        url:"/api/map/" + employee_name + "/" + task_name,
        data:$.toJSON({
            "workload":workload
        }),
        success:success_handler,
        error:error_handler
    });
};

del_workload = function (employee_name, task_name, success_handler, error_handler) {
    $.ajax({
        type:"DELETE",
        url:"/api/map/" + employee_name + "/" + task_name,
        data:$.toJSON({
            "workload":true
        }),
        success:success_handler,
        error:error_handler
    });
};

map_quantity = function (employee_name, task_name, quantity, success_handler, error_handler) {
    $.ajax({
        type:"POST",
        url:"/api/map/" + employee_name + "/" + task_name,
        data:$.toJSON({
            "quantity":quantity
        }),
        success:success_handler,
        error:error_handler
    });
};

del_quantity = function (employee_name, task_name, success_handler, error_handler) {
    $.ajax({
        type:"DELETE",
        url:"/api/map/" + employee_name + "/" + task_name,
        data:$.toJSON({
            "quantity":true
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
