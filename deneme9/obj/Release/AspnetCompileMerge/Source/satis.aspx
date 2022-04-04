<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" EnableViewState="true" EnableEventValidation="false" CodeBehind="satis.aspx.cs" Inherits="kurumsal.kurumsaluser.anasayfa" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 
    <section class="content-header">

        <asp:Label ID="Label3" runat="server" Font-Size="25px" Text=""></asp:Label>
        <asp:Label ID="Label4" CssClass="pull-right" runat="server" Font-Size="25px" Text=""></asp:Label>

    </section>
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
                    <div class="box-body">
                        <div class="box">
                            <div class="box-body table-responsive no-padding">
                                <table class="table table-hover">
                                    <tbody>

                                        <asp:Repeater ID="Repeater3" runat="server">
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
                </div>
            </div>
        </div>
    </div>

    <section class="content">
        <%--repeater start--%>
       
        <asp:Repeater ID="Repeater1" OnItemDataBound="Repeater1_ItemDataBound" runat="server">
           
            <ItemTemplate>
                 
                <div id='<%# Eval("UrunID")+"_" %>' class="row">
                   
                    <div class="col-lg-12">
                        <div class="box box-warning  collapsed-box box-solid">
                            <div class="box-header with-border">
                                <asp:Image ID="Image1" class="img-circle" ImageUrl='<%# Eval("UrunResim_Path") %>' Width="80px" runat="server" />
                                <h1 class="box-title">&#160; &#160;&#160; <%# Eval("UrunADI") %></h1>

                                <div class=" box-tools   pull-right">
                                    <button class=" btn btn-box-tool" style="width: 60px; height: 60px" data-widget="collapse"><i class="fa fa-plus"></i></button>
                                </div>
                                <!-- /.box-tools -->
                            </div>
                            <!-- /.box-header -->
                            <div  class="box-body">
                                 
                                <asp:Label ID="Labelfiyat" runat="server" Visible="false" Text='<%# Eval("UrunFiyat") %>' CssClass="resimlbl"></asp:Label>
                                <asp:Label ID="Labelurunıd" runat="server" Visible="false" Text='<%# Eval("UrunID") %>' CssClass="resimlbl"></asp:Label>
                                <asp:Label ID="Labelkar" runat="server" Visible="false" Text='<%# Eval("UrunKar_Yuzde") %>' CssClass="resimlbl"></asp:Label>
                                <asp:Label ID="Labeladı" runat="server" Visible="false" Text='<%# Eval("UrunADI") %>' CssClass="resimlbl"></asp:Label>
                                <asp:Label ID="LabelID" runat="server" Visible="true" Text='<%# Eval("UrunID") %>' CssClass="resimlbl"></asp:Label>
                                <div class="form-group">

                                    <asp:DropDownList ID="DropDownListadet" enableEventValidation="False"  AutoPostBack="false" AppendDataBoundItems="true" CssClass="form-control" runat="server">
                                        <asp:ListItem  Value="0">-- ADET SEÇ --</asp:ListItem>
                                       
                                    </asp:DropDownList>
                                </div>
                                <div id="MFDİV" runat="server" class="form-group">

                                    <asp:DropDownList ID="DropDownListmf" AppendDataBoundItems="true" CssClass="form-control" runat="server">
                                        <asp:ListItem Value="0">-- MF SEÇ --</asp:ListItem>
                                    </asp:DropDownList>
                                </div>


                                <div class="form-group" style="width: 200px;">
                                    <asp:Button ID="Button1" enableEventValidation="False" runat="server" CssClass="btn btn-block btn-primary" OnCommand="ButtonComand" Text="EKLE" />

                                </div>
                                <asp:Panel ID="pnl_gdogru" Visible="false" runat="server">
                                    <div class="form-group">
                                        <div class="alert alert-success alert-dismissable">
                                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                            <h4><i class="icon fa fa-check"></i>Eklendi!</h4>
                                            Başarıyla Eklendi...
                                        </div>
                                    </div>
                                </asp:Panel>
                                <asp:Panel ID="pnl_gyanlis" Visible="false" runat="server">
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
                <%--repeater bitiş--%>
            </ItemTemplate>
        </asp:Repeater>
        <div class="row">
            <div class="col-lg-12">
                <div class="box box-warning box-solid">
                    <div class="box-header with-border">
                        <h3 class="box-title">Sipariş Detay</h3>
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
                                            <th>UrunADI</th>
                                            <th>Adet</th>
                                            <th>Malfazlası Adeti</th>
                                            <th>Toplam</th>
                                            <th>Birim Fiyatı</th>
                                            <th>Satış Fiyatı</th>
                                            <th>Eczane ID</th>
                                            <th>Sil</th>
                                        </tr>
                                        <asp:Repeater ID="Repeater2" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("SiparisID") %>'></asp:Label>
                                                    </td>
                                                    <td>

                                                        <asp:Label ID="Adet" runat="server" Text='<%# Eval("UrunADI") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="MalFazlasıAdeti" runat="server" Text='<%# Eval("Adet") %>'></asp:Label>

                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Toplam" runat="server" Text='<%# Eval("MalfazlasıAdet") %>'></asp:Label>

                                                    </td>
                                                    <td>
                                                        <asp:Label ID="BirimFiyatı" runat="server" Text='<%# Eval("Toplam") %>'></asp:Label>

                                                    </td>
                                                    <td>
                                                        <asp:Label ID="SatışFiyatı" runat="server" Text='<%# Eval("BirimFiyat") %>'></asp:Label>


                                                    </td>
                                                    <td>
                                                        <asp:Label ID="EczaneID" runat="server" Text='<%# Eval("SatışFiyat") %>'></asp:Label>


                                                    </td>
                                                    <td>
                                                        <asp:Label ID="label7" runat="server" Text='<%# Eval("EczaneID") %>'></asp:Label>
                                                    </td>

                                                    <td>

                                                        <a style="font-size: 20px;" href='satis.aspx?SiparişID=<%#Eval("SiparisID") %>&islem=sil&EczaneID=<%#Eval("EczaneID") %>'><i class="fa fa-trash-o"></i></a>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>


                                    </tbody>
                                </table>
                            </div>
                            <!-- /.box-body -->
                        </div>

                        <asp:Button ID="btn_siparisver" enableEventValidation="False" runat="server" CssClass="btn btn-block btn-primary" OnClick="btn_siparisver_Click" Text="Sipariş Ver" />
                        <!-- /.box -->
                    </div>

                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
        </div>
    </section>
</asp:Content>
