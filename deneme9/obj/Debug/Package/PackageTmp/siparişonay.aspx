<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="siparişonay.aspx.cs" EnableEventValidation="false" Inherits="kurumsal.kurumsaluser.hizmetler" %>

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
        <!-- Button trigger modal -->


        <!-- Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Siparişi Onayla</h4>
                    </div>
                    <div class="modal-body">



                        <div class="box-body">
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
                                            <asp:Repeater ID="RepeaterSiparişOnayModal" runat="server">
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



                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
                        <asp:Button ID="ButtonSiparisonayla" runat="server" Text="Onayla" OnClick="ButtonSiparisonayla_Click" class="btn btn-primary" />
                    </div>
                </div>
            </div>
        </div>
          <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel1">Siparişi Reddet</h4>
                    </div>
                    <div class="modal-body">



                        <div class="box-body">
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
                                            <asp:Repeater ID="Repeater1" runat="server">
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



                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
                        <asp:Button ID="Button1" runat="server" Text="Reddet" OnClick="ButtonSiparisReddet_Click" class="btn btn-primary" />
                    </div>
                </div>
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


                                        <asp:Repeater ID="RepeaterEczaneBilgi" runat="server">
                                            <ItemTemplate>
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
                                                    <th>Oluşturulma Tarihi</th>
                                                    <th><%# Eval("OlusturulmaTar","{0:dd MMMM yyyy}") %></th>
                                                </tr>
                                                <tr>
                                                    <th>Son Ziyaret Tarihi</th>
                                                    <th><%# Eval("Sonziyarettar","{0:dd MMMM yyyy}") %></th>
                                                </tr>
                                                <tr>
                                                    <th>Eczane ID</th>
                                                    <th><%# Eval("EczaneID") %></th>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                        <%--<asp:Repeater ID="Repeater1" OnItemDataBound="ItemBound"  runat="server">
                            <ItemTemplate>--%>
                        <asp:Label ID="myLabel" Visible="false" runat="server" Text='<%# getsiparisıd(Eval("SiparislerID").ToString()) %>' />


                        <div class="box-body">

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


                        <%--</ItemTemplate>
                        </asp:Repeater>--%>
                        <div class="row">
                            <div class="form-group col-lg-6 ">
                                <button type="button" class="btn btn-block btn-primary " data-toggle="modal" data-target="#myModal">
                                    Siparişi Onayla 
                                </button>
                            </div>
                            <div class="form-group col-lg-6 ">
                                <button type="button" class="btn btn-block" data-toggle="modal" data-target="#myModal1">
                                    Siparişi Reddet 
                                </button>
                            </div>

                        </div>
                    </div>



                </div>

            </div>
        </div>


        <!-- /.box -->

        <!-- /.col -->

        <div class="row">
            <div class="col-lg-12">
                <div class="box box-warning box-solid">
                    <div class="box-header with-border">
                        <h3 class="box-title">Hizmetler</h3>
                        <div class="box-tools pull-right">
                            <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-search"></i></button>
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
                                            <th>Siparis ID</th>
                                            <th>EczaneID</th>
                                            <th>Eczane ADI</th>
                                            <th>Şehir</th>
                                            <th>İlçe</th>
                                            <th>Semt</th>
                                            <th>Mahalle</th>
                                            <th>Durum</th>
                                            <th>İncele</th>
                                        </tr>


                                        <asp:Repeater ID="RepeaterSiparisOnayDurum" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <th><%# Eval("SiparislerID") %></th>
                                                    <th><%# Eval("EczaneID") %></th>
                                                    <th><%# Eval("Eczane_ADI") %></th>
                                                    <th><%# Eval("Şehirtxt") %></th>
                                                    <th><%# Eval("ilçetxt") %></th>
                                                    <th><%# Eval("semttxt") %></th>
                                                    <th><%# Eval("mahalletxt") %></th>
                                                    <th><span class='<%# Onaydurum(Eval("tip").ToString())%>' ><%# Onaydurum(Convert.ToInt32( Eval("tip")))%></span></th>
                                                    <td><a href='siparişonay.aspx?EczaneID=<%#Eval("EczaneID") %>&siparisID=<%# Eval("SiparislerID") %>'><i class="fa fa fa-search"></i></a></td>

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
