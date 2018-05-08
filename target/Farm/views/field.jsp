<%--
  Created by IntelliJ IDEA.
  User: Eternity-Myth
  Date: 2018/5/5
  Time: 20:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=gbk" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>�˵���Ϣһ��</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <script type="text/javascript"
            src="${APP_PATH}/js/jquery-3.3.1.js"></script>
    <link
            href="${APP_PATH}/css/bootstrap.min.css"
            rel="stylesheet">
    <script
            src="${APP_PATH}/js/bootstrap.min.js"></script>
</head>
<body>
<!-- �˵����ӵ�ģ̬�� -->
<div class="modal fade" id="fieldAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">�˵�����</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">�˵����</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="fieldArea_add_input" placeholder="Area">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">�˵�����</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="fieldCrops_add_input" placeholder="Crops">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">�ر�</button>
                <button type="button" class="btn btn-primary" id="field_save_btn">����</button>
            </div>
        </div>
    </div>
</div>
<%--���ʾҳ��--%>
<div class="container">
    <%--����--%>
    <div class="row">
        <div class="col-md-12">
            <h2>�˵���Ϣһ��</h2>
        </div>
    </div>
    <%--��ť--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="field_add_modal_btn">����</button>
            <button class="btn btn-danger" id="field_delete_all_btn">ɾ��</button>
        </div>
    </div>
    <%--��ʾ��������--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="field_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>#ID</th>
                    <th>Area</th>
                    <th>Crops</th>
                    <th>����</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
    <!-- ��ʾ��ҳ��Ϣ -->
    <div class="row">
        <!--��ҳ������Ϣ  -->
        <div class="col-md-6" id="page_info_area"></div>
        <!-- ��ҳ����Ϣ -->
        <div class="col-md-6" id="page_nav_area">
        </div>
    </div>
</div>
<script type="text/javascript">

    var totalRecord, currentPage;
    //1��ҳ���������Ժ�ֱ��ȥ����ajax����,Ҫ����ҳ����
    $(function () {
        //ȥ��ҳ
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/field-list",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                //1����������ʾ�˵�����
                build_field_table(result);
                //2����������ʾ��ҳ��Ϣ
                build_page_info(result);
                //3��������ʾ��ҳ������
                build_page_nav(result);
            }
        });
    }

    function build_field_table(result) {
        //���table����
        $("#field_table tbody").empty();
        var field = result.extend.pageInfo.list;
        $.each(field, function (index, item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var fieldIdTd = $("<td></td>").append(item.id);
            var fieldAreaTd = $("<td></td>").append(item.area);
            var fieldCropsTd = $("<td></td>").append(item.crops);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("�༭");
            //Ϊ�༭��ť����һ���Զ�������ԣ�����ʾ��ǰ�˵�id
            editBtn.attr("edit-id", item.id);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("ɾ��");
            //Ϊɾ����ť����һ���Զ������������ʾ��ǰɾ���Ĳ˵�id
            delBtn.attr("del-id", item.id);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            //append����ִ������Ժ��Ƿ���ԭ����Ԫ��
            $("<tr></tr>").append(checkBoxTd)
                .append(fieldIdTd)
                .append(fieldAreaTd)
                .append(fieldCropsTd)
                .append(btnTd)
                .appendTo("#field_table tbody");
        });
    }

    //������ʾ��ҳ��Ϣ
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("��ǰ��" + result.extend.pageInfo.pageNum + "ҳ,��" +
            result.extend.pageInfo.pages + "ҳ,��" +
            result.extend.pageInfo.total + "����¼");
        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }

    //������ʾ��ҳ���������ҳҪ��ȥ��һҳ....
    function build_page_nav(result) {
        //page_nav_area
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");

        //����Ԫ��
        var firstPageLi = $("<li></li>").append($("<a></a>").append("��ҳ").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            //ΪԪ�����ӵ����ҳ���¼�
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("ĩҳ").attr("href", "#"));
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }


        //������ҳ��ǰһҳ ����ʾ
        ul.append(firstPageLi).append(prePageLi);
        //1,2��3������ul������ҳ����ʾ
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {

            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        //������һҳ��ĩҳ ����ʾ
        ul.append(nextPageLi).append(lastPageLi);

        //��ul���뵽nav
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    $("#field_add_modal_btn").click(function () {
        $("#fieldAddModal").modal({
            backdrop: "static"
        });
    });

    // $("#field_save_btn").click(function () {
    //1��ģ̬������д�ı��������ύ�����������б���
    //2������ajax���󱣴�˵���Ϣ
    // alert($("#fieldAddModal form").serialize())
    <%--$.ajax({--%>
    <%--url: "${APP_PATH}/field",--%>
    <%--type: "POST",--%>
    <%--data: $("#fieldAddModal form").serialize(),--%>
    <%--success: function (result) {--%>
    <%--//�˵���Ϣ����ɹ�--%>
    <%--//1���ر�ģ̬��--%>
    <%--$("#fieldAddModal").modal.hide();--%>
    <%--//2���������һҳ����ʾ�ղű��������--%>
    <%--//����ajax������ʾ���һҳ���ݼ���--%>
    <%--to_page(totalRecord);--%>
    <%--}--%>
    <%--});--%>
    // });

    //����ɾ��
    $(document).on("click", ".delete_btn", function () {
        //1�������Ƿ�ȷ��ɾ���Ի���
        var fieldId = $(this).attr("del-id");
        if (confirm("ȷ��ɾ����")) {
            //ȷ�ϣ�����ajax����ɾ������
            $.ajax({
                url: "${APP_PATH}/field/" + fieldId,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    //�ص���ҳ
                    to_page(currentPage);
                }
            });
        }
    });

    //���ȫѡ/ȫ��ѡ����
    $("#check_all").click(function () {
        //attr��ȡchecked��undefined;
        //������Щdomԭ�������ԣ�attr��ȡ�Զ������Ե�ֵ��
        //prop�޸ĺͶ�ȡdomԭ�����Ե�ֵ
        $(".check_item").prop("checked", $(this).prop("checked"));
    });

    //check_item
    $(document).on("click", ".check_item", function () {
        //�жϵ�ǰѡ���е�Ԫ���Ƿ��ҳ����Ԫ��
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked", flag);
    });

    //���ȫ��ɾ����������ɾ��
    $("#field_delete_all_btn").click(function () {
        //
        var del_idstr = "";
        $.each($(".check_item:checked"), function () {
            //��װ�˵�id�ַ���
            del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });
        //ȥ��ɾ����id�����-
        del_idstr = del_idstr.substring(0, del_idstr.length - 1);
        if (confirm("ȷ��ɾ����")) {
            //����ajax����ɾ��
            $.ajax({
                url: "${APP_PATH}/field/" + del_idstr,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    //�ص���ǰҳ��
                    to_page(currentPage);
                }
            });
        }
    });
</script>
</body>
</html>