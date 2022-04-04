<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="Sınav.aspx.cs" Inherits="deneme9.Sınav" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        #touch, #click {
            position: relative;
            left: 100px;
            top: 100px;
            width: 200px;
            height: 200px;
            border: solid 1px black;
        }
    </style>
    <script type="text/javascript">
        $('li').each(function () {
            this.onclick = function () {

            }
        });
        jQuery(document).on('click', '.items li', function (e) {
            out.innerText += "CLICK\n";
        });
        jQuery(document).on('touchstart', '.items li', function (e) {
            out.innerText += "Touch\n";
        });
        jQuery(document).on('click', 'a', function (e) {
            out.innerText += "CLICK Anchror\n";
            e.preventDefault();
        });
        out.innerText += "init 2\n";
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


   <h3>Sections</h3>
  <div class=items>
    <a href="#">Anchor</a>
    <li>Section</li>
    <li>Section</li><li>Section</li>
    <li>Section</li><section>Section</section>
    <section>Section</section><section>Section</section>
    
  </div>
  <h3>Output</h3>
  <pre id=out></pre>
</asp:Content>
