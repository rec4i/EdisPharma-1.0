<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="kullanıciislemleri.aspx.cs" Inherits="deneme9.kullanıciislemleri" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



    <section class="content-header">
        <h1>Makaleler</h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Makaleler</a></li>
        </ol>
    </section>

    <section class="content">

        <div class="row">
            <div class="col-lg-12">
                <div class="box box-warning box-solid">
                    <div class="box-header with-border">
                        <h3 class="box-title">Eczane Detay</h3>
                        <div class="box-tools pull-right">
                            <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                        </div>
                        <!-- /.box-tools -->
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="form-group">
                            <label id="AD" runat="server">Ad</label>
                            <asp:TextBox ID="ADtxt" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label id="Soyad" runat="server">Soyad</label>
                            <asp:TextBox ID="Soyadtxt" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label id="Kullanıcı_Adı" runat="server">Kullanıcı Adı</label>
                            <asp:TextBox ID="Kullanıcı_Adıtxt" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label id="Şifre" runat="server">Şifre</label>
                            <asp:TextBox ID="Şifretxt" TextMode="Password" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label id="Şifre_Yeniden" runat="server">Şifre Yeniden</label>
                            <asp:TextBox ID="Şifre_Yenidentxt" TextMode="Password" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label id="YetkiLbl" runat="server">Yetki</label>
                            <asp:DropDownList ID="DropDownList_yetki" AppendDataBoundItems="true" DataTextField="DistrictName"
                                DataValueField="DistrictID" CssClass="form-control" runat="server">
                                <asp:ListItem Value="0">-- Yetki Seç --</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="form-group">
                            <asp:Button ID="Button1" enableEventValidation="False" runat="server" CssClass="btn btn-block btn-primary" OnClick="Button1_Click" Text="Oluştur" />
                        </div>



                        <asp:Panel ID="pnl_gdogru" runat="server">
                            <div class="form-group">
                                <div class="alert alert-success alert-dismissable">
                                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                    <h4><i class="icon fa fa-check"></i>Düzenlendi!</h4>
                                    Başarıyla Düzenlendi...
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

        <div id="EczaneDetayRow" runat="server" class="row">
            <div class="col-lg-12">
                <div id="EczaneBilgiDiv" runat="server" cssclass="" class="box box-default collapsed-box box-solid">
                    <div class="box-header with-border">
                        <h3 class="box-title"></h3>

                        <div class="box-tools pull-right">
                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                <i class="fa fa-plus"></i>

                            </button>
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
                                            <th>Ad</th>
                                            <th>Soyad</th>
                                            <th>Kullanıcı Adı</th>
                                            <th>Şifre</th>
                                            <th>Yetki</th>

                                        </tr>


                                        <asp:Repeater ID="RepeaterKullanıcıBilgiÇekme" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <th><%# Eval("KullanıcıID") %></th>
                                                    <th><%# Eval("AD") %></th>
                                                    <th><%# Eval("Soyad") %></th>
                                                    <th><%# Eval("KullanıcıAD") %></th>
                                                    <th><%# Eval("KullanıcıPass") %></th>
                                                    <th><%# Eval("KullanıcıYetki") %></th>
                                                    

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
        </div>
    </section>



</asp:Content>
