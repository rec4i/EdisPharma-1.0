<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="eczaneara.aspx.cs" EnableEventValidation="false" Inherits="kurumsal.kurumsaluser.haberler" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <section class="content-header">
        <h1>Hizmetler</h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Hizmetler</a></li>
        </ol>
    </section>
    <section class="content">
        
        <div class="row">
            <div class="col-lg-12">
                <div class="box box-warning box-solid">
                    <div class="box-header with-border">
                        <h3 class="box-title">Hizmetler</h3>
                        <div class="box-tools pull-right">
                            <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                        </div>
                        <!-- /.box-tools -->
                    </div>
                    <!-- /.box-header -->
                     
                    <div class="box-body">
                        <div class="form-group">
                            <label id="Label3" runat="server">Eczane Adı</label>
                            <asp:TextBox ID="txt_eczaneadı" CssClass="form-control" runat="server"></asp:TextBox><br />
                             <asp:Button ID="Button2" runat="server" Height="50px" OnClick="Button1_Click" CssClass="btn btn-block btn-primary" Text="Ara"  />
                        </div>
                        <div class="box">
                            
                            <div class="box-body table-responsive no-padding">
                                <table class="table table-hover">
                                    <tbody>
                                        <tr>
                                            <th>ID</th>
                                            <th>Eczane Adı</th>
                                            <th>İlçe</th>
                                            <th>Semt</th>
                                            <th>Mahalle</th>
                                            <th>Son Ziyaret</th>
                                            <th>Görüntüle</th>
                                            <th>Satış</th>
                                        </tr>
                                        <asp:Repeater ID="Repeater1" runat="server">
                                            
                                           
                                            <ItemTemplate>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label1" runat="server" Text='<%#Eval("EczaneID") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label2" runat="server" Text='<%#Eval("Eczane_ADI") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label3" runat="server" Text='<%#Eval("ilçetxt") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label4" runat="server" Text='<%#Eval("semttxt") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label5" runat="server" Text='<%#Eval("mahalletxt") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label6" runat="server" Text='<%#Eval("Sonziyarettar") %>'></asp:Label>
                                                    </td>
                                                    <td><a href="eczanedetay.aspx?EczaneID=<%#Eval("EczaneID") %>"><i class="fa fa-pencil"></i></a></td>
                                                    <td><a href='satis.aspx?EczaneID=<%#Eval("EczaneID") %>'><i class="fa  fa-dollar"></i></a></td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </tbody>
                                </table>
                            </div>
                            <!-- /.box-body -->
                        </div>
                        <!-- /.box -->
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
        </div>
    </section>
</asp:Content>
