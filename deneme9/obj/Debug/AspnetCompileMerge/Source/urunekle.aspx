<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="urunekle.aspx.cs" Inherits="kurumsal.kurumsaluser.hizmetduzenle" %>
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
        <asp:Image ID="img1" Visible="false" runat="server" />
        <div class="row">
            <div class="col-lg-12">
                <div class="box box-warning box-solid">
                    <div class="box-header with-border">
                        <h3 class="box-title">Hizmet Ekle</h3>
                        <div class="box-tools pull-right">
                            <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                        </div>
                        <!-- /.box-tools -->
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="form-group">
                            <label id="Label1" runat="server">Ürun Adı    (Lütfen Ürün Adında "(-),(.),(=),(?)" gibi işaretler kullanmayınız)</label>
                            <asp:TextBox ID="txt_UrunAdı" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputFile">Resim Seç</label>
                            <asp:FileUpload ID="FileUpload1" runat="server" />
                            <p class="help-block">Resim Ekle</p>
                        </div>
                        <div class="form-group">
                            <label id="Label2" runat="server">Ürun Fiyatı(Lütfen Ürün 100TL ise 100 Şekilnde Giriniz)</label>
                            <asp:TextBox ID="txt_Fiyat" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                       <div class="form-group">
                            <label id="Label3" runat="server">Ürün Kar(Lütfen Kar %25 ise 25 şeklinde giriniz)</label>
                            <asp:TextBox ID="txt_Kar" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group" style="width: 200px;">
                            <asp:Button ID="Button1" runat="server" CssClass="btn btn-block btn-primary" Text="EKLE" OnClick="Button1_Click" />
                            <asp:Button ID="btn_mtemizle" runat="server" CssClass="btn btn-block btn-danger" Text="TEMİZLE" />
                        </div>
                        <asp:Panel ID="pnl_gdogru" runat="server">
                            <div class="form-group">
                                <div class="alert alert-success alert-dismissable">
                                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                    <h4><i class="icon fa fa-check"></i>Eklendi!</h4>
                                    Başarıyla Eklendi...
                                </div>
                            </div>
                        </asp:Panel>
                        <asp:Panel ID="pnl_gyanlis" runat="server">
                            <div class="form-group">
                                <div class="alert alert-danger alert-dismissable">
                                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                    <h4><i class="icon fa fa-ban"></i>Hata!</h4>
                                    Bir Sorun Çıktı Boşlukları Doldurun Lütfen...
                                </div>
                            </div>
                        </asp:Panel>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
        </div>
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
                        <div class="box">
                            <div class="box-body table-responsive no-padding">
                                <table class="table table-hover">
                                    <tbody>
                                        <tr>
                                            <th>ID</th>
                                            <th>Ürün Adı</th>
                                            <th>Ürün Fiyatı</th>
                                            <th>Ürün Karı</th>
                                            <th>Ürün Resimi</th>
                                            <th>Sil</th>
                                        </tr>
                                        <asp:Repeater  ID="Repeater1" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label4" Font-Size="25px" runat="server" Text='<%#Eval("UrunID") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label5" Font-Size="25px" runat="server" Text='<%#Eval("UrunADI") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label6" Font-Size="25px" runat="server" Text='<%#Eval("UrunFiyat") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label7" Font-Size="25px" runat="server" Text='<%#Eval("UrunKar_Yuzde") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                       <asp:Image ID="img2" CssClass="img-circle" Height="70px" ImageUrl='<%#Eval("UrunResim_Path") %>' runat="server" />
                                                    </td>
                                                    <td><a href=""><i class="fa fa-pencil"></i></a></td>
                                                    <td><a href=""><i class="fa fa-trash-o"></i></a></td>
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
