<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="Araç-Bakim-Takibi.aspx.cs" Inherits="deneme9.Araç_Bakim_Takibi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script type="text/javascript"> 

        $(document).ready(function () {
           
            $(".js-example-placeholder-multiple").select2({
                placeholder: "Select a state",
               
            });
            var Select1 = $('#Select1')
        
            var Button1 = $('#Button1')
            var a = 0;
            Button1.click(function () {
                Select1.append('<option> ' + a + '</option>')
                a++;
            })
        })
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="rox">
        <div class="box">
            <div class="box-body">
              <select class="js-example-placeholder-multiple js-states form-control" id="Select1" multiple="multiple">
              </select>
            </div>
            <div class="box-footer">
                <input type="button" id="Button1"  value="asdaads"/>
            </div>
        </div>

    </div>

</asp:Content>
