<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="ajax.aspx.cs" Inherits="deneme9.ajax" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        var output = "123123213213231";
        $(document).ready(function () {
            $("#btnGonder").click(function () {
                $.ajax({
                    url: 'ajax.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '123554'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        alert(output + ajaxCallBack(data.d));

                    }
                });
            });
        });
        var output = "Degismedi";
        function ajaxCallBack(retString) {
            output = retString;
            return output;
        }



    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">




    <div class="container">
        <h1>Hello World!</h1>
        <div class="row">
            <div class="col-sm-1" style="background-color: yellow;">
                <p>Lorem ipsum...</p>
            </div>
             <div class="col-sm-1" style="background-color: yellow;">
                <p>Lorem ipsum...</p>
            </div>
             <div class="col-sm-1" style="background-color: yellow;">
                <p>Lorem ipsum...</p>
            </div>
             <div class="col-sm-1" style="background-color: yellow;">
                <p>Lorem ipsum...</p>
            </div>
            <div class="col-sm-1" style="background-color: pink;">
                <p>Sed ut perspiciatis...</p>
            </div>
        </div>
    </div>


</asp:Content>
