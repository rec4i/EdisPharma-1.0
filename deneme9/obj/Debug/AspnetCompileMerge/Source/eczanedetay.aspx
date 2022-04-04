<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="eczanedetay.aspx.cs" Inherits="kurumsal.kurumsaluser.makaleduzenle" %>


<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header">
        <h1>Eczane Detay</h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Eczaneler</a></li>
        </ol>
    </section>

    <section class="content">
        <div id="EczaneDetayRow" runat="server" class="row">
            <div class="col-lg-12">
                <div id="EczaneBilgiDiv" runat="server" cssclass="" class="box box-default collapsed box-solid">
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


                                        <asp:Repeater ID="RepeaterEczaneBilgi" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <th>Eczane ID</th>
                                                    <th><%# Eval("EczaneID") %></th>
                                                </tr>
                                                <tr>
                                                    <th>Eczane ADI</th>
                                                    <th><%# Eval("Eczane_ADI") %></th>
                                                </tr>
                                                <tr>
                                                    <th>Eczacı ADI</th>
                                                    <th><%# Eval("Eczacı_ADI") %></th>
                                                </tr>
                                                <tr>
                                                    <th>Şehir</th>
                                                    <th><%# Eval("Şehirtxt") %></th>
                                                </tr>
                                                <tr>
                                                    <th>İlçe</th>
                                                    <th><%# Eval("ilçetxt") %></th>
                                                </tr>
                                                <tr>
                                                    <th>Semt</th>
                                                    <th><%# Eval("semttxt") %></th>
                                                </tr>
                                                <tr>
                                                    <th>Mahalle</th>
                                                    <th><%# Eval("mahalletxt") %></th>
                                                </tr>
                                                <tr>
                                                    <th>Telefon-1</th>
                                                    <th><%# Eval("telefon") %></th>
                                                </tr>
                                                <tr>
                                                    <th>Telefon-2</th>
                                                    <th><%# Eval("telefon2") %></th>
                                                </tr>
                                                <tr>
                                                    <th>NOT</th>
                                                    <th><%# Eval("NOTLAR") %></th>
                                                </tr>
                                                <tr>
                                                    <th>Oluşturulma Tarihi</th>
                                                    <th><%# Eval("OlusturulmaTar","{0:dd MMMM yyyy}") %></th>
                                                </tr>
                                                <tr>
                                                    <th>Son Ziyaret Tarihi</th>
                                                    <th><%# Eval("Sonziyarettar","{0:dd MMMM yyyy}") %></th>
                                                </tr>

                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                        <div class="box-body">
                            <div class="box">
                                <div class="box-body table-responsive no-padding">
                                    <table class="table table-hover">
                                        <tbody>

                                            <asp:Repeater ID="Repeater2" runat="server">
                                                <ItemTemplate>
                                                    <tr>
                                                        <th><%# getUrunadı( Eval("COLUMN_NAME").ToString()) %></th>
                                                        <th><%# getstokadet( (string)Eval("COLUMN_NAME")) %></th>
                                                    </tr>

                                                </ItemTemplate>
                                            </asp:Repeater>



                                        </tbody>
                                    </table>
                                </div>
                            </div>

                        </div>
                         <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:Button ID="Button1" runat="server" data-toggle="modal" data-target="#myModal" CssClass="btn-lg btn-block btn-primary" OnClick="Button1_Click" Text="Satış" />

                                </div>
                            </div>
                        </div>
                          <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:Button ID="Button3" runat="server" data-toggle="modal" data-target="#myModal" CssClass="btn-lg btn-block btn-primary" OnClick="Button3_Click" Text="Stok Güncelle" />

                                </div>
                            </div>
                        </div>
                         <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:Button ID="Button2" runat="server" data-toggle="modal" data-target="#myModal" CssClass="btn-lg btn-block btn-primary" OnClick="Button2_Click" Text="Düzenle" />

                                </div>
                            </div>
                        </div>
                        
                         <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:Button ID="Button4" runat="server" data-toggle="modal" data-target="#myModal" CssClass="btn-lg btn-block btn-danger" OnClick="Button4_Click" Text="Eczaneyi Sil" />

                                </div>
                            </div>
                        </div>
                        <asp:Repeater ID="Repeater1" OnItemDataBound="ItemBound" runat="server">
                            <ItemTemplate>
                                <asp:Label ID="myLabel" Visible="false" runat="server" Text='<%# getsiparisıd(Eval("SiparislerID").ToString()) %>' />


                                <div class="box-body">
                                    <asp:Label ID="Label1" CssClass='<%# getonaydurum(Eval("OnayDurum").ToString()) %>' runat="server" Text='<%# getonaydurum(Convert.ToInt32( Eval("OnayDurum"))) %>' />
                                    <div class="box">

                                        <div class="box-body table-responsive no-padding">


                                            <table class="table table-hover">

                                                <tbody>

                                                    <tr>
                                                        <th>Siparis ID</th>
                                                        <th>Urun ADI</th>
                                                        <th>Adet</th>
                                                        <th>Mal Fazlası Adeti</th>
                                                        <th>Toplam</th>
                                                        <th>Birim Fiyatı</th>
                                                        <th>N. Satış Fiyatı</th>
                                                        <th>S. Oluşturulma Tarihi</th>

                                                    </tr>
                                                    <asp:Repeater ID="RepeaterSiparisBilgi" runat="server">
                                                        <ItemTemplate>

                                                            <tr>
                                                                <th><%# Eval("SiparisID") %></th>


                                                                <th><%# Eval("UrunAdı") %></th>


                                                                <th><%# Eval("Adet") %></th>

                                                                <th><%# Eval("MalFazlasıAdet") %></th>

                                                                <th><%# Eval("Toplam") %></th>

                                                                <th><%# Eval("BirimFiyat") %></th>

                                                                <th><%# Eval("SatışFiyat") %></th>

                                                                <th><%# Eval("SiparisOlusturulmaTar","{0:dd MMMM yyyy}") %></th>
                                                            </tr>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </tbody>

                                            </table>

                                        </div>
                                    </div>
                                </div>




                            </ItemTemplate>
                        </asp:Repeater>
                       


                    </div>

                </div>

            </div>
        </div>

    </section>

</asp:Content>
