<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="yenieczane.aspx.cs" Inherits="kurumsal.kurumsaluser.haberduzenle" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header">
        <h1>Eczane </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Eczane</a></li>
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
                        <h4 class="modal-title" id="myModalLabel">Bilgileri Güncelle</h4>
                    </div>
                    <div class="modal-body">

                        

                        <div class="box-body">
                            <div class="box">
                                <div class="box-body table-responsive no-padding">
                                    <h1>Bilgileri Güncellemek İstediğinizden Eminmisiniz</h1>
                                </div>

                            </div>

                        </div>



                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
                      <asp:Button ID="Button3" runat="server" CssClass="btn btn-primary" OnClick="Button3_Click" Text="Bilgileri Güncelle"  />
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="box box-warning box-solid">
                    <div class="box-header with-border">
                        <h3 id="boxtitle" runat="server" class="box-title">Eczane Ekle</h3>
                        <div class="box-tools pull-right">
                            <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                        </div>
                        <!-- /.box-tools -->
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="form-group">
                            <label id="Label3" runat="server">Eczane Adı</label>
                            <asp:TextBox ID="txt_EczaneAdı" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label id="Label1" runat="server">Eczacı Adı</label>
                            <asp:TextBox ID="txt_EczacıAdı" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label id="Label2" runat="server">Şehir</label>
                            <asp:DropDownList ID="DropDownListmf" OnSelectedIndexChanged="DropDownListmf_SelectedIndexChanged"  AutoPostBack="true" DataTextField="cityName"
                                DataValueField="cityID" AppendDataBoundItems="true" CssClass="form-control" runat="server">
                                <asp:ListItem Value="0">-- Şehir Seç --</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label id="Label4" runat="server">İlçe</label>
                            <asp:DropDownList ID="DropDownList1" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged"   AutoPostBack="true" DataTextField="TownNAME"
                                DataValueField="TownID" AppendDataBoundItems="true" CssClass="form-control" runat="server">
                                <asp:ListItem Value="0">-- İlçe Seç --</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label id="Label5" runat="server">Semt</label>
                            <asp:DropDownList ID="DropDownList2" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged"  AutoPostBack="true" DataTextField="DistrictName"
                                DataValueField="DistrictID" AppendDataBoundItems="true" CssClass="form-control" runat="server">
                                <asp:ListItem Value="0">-- Semt Seç --</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label id="Label6" runat="server">Mahalle</label>
                            <asp:DropDownList ID="DropDownList3" AppendDataBoundItems="true" DataTextField="NeighborhoodName"
                                DataValueField="NeighborhoodID" CssClass="form-control" runat="server">
                                <asp:ListItem Value="0">-- Mahalle Seç --</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label id="Label7" runat="server">Telefon 1</label>
                            <asp:TextBox ID="txt_Telefon1" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label id="Label8" runat="server">Telefon 2</label>
                            <asp:TextBox ID="txt_Telefon2" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                        
                        <div class="form-group">
                            <label id="Label9" runat="server">Notlar</label>     
                            <asp:TextBox ID="txt_Notlar" CssClass="form-control" Height="100px" TextMode="MultiLine" runat="server"></asp:TextBox>
                        </div>
                       


                        <div class="form-group" style="width: 100%;">
                            <asp:Button ID="Button1" runat="server" CssClass="btn-lg btn-block btn-primary" Text="Ekle" OnClick="Button1_Click" />
                            <asp:Button ID="Button2" runat="server" CssClass="btn-lg btn-block btn-primary" OnClick="Button2_Click" Text="Ekle ve satışa git"  />
                            
                           
                                <button type="button" id="buttonguncelle" runat="server" class="btn-lg btn-block btn-primary " data-toggle="modal" data-target="#myModal">
                                    Bilgileri Güncelle
                                </button>
                           
                        </div>
                        <asp:Panel ID="pnl_gdogru"  runat="server">
                            <div class="form-group">
                                <div class="alert alert-success alert-dismissable">
                                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                    <h4><i class="icon fa fa-check"></i>Eklendi!</h4>
                                    Başarıyla Eklendi...
                                </div>
                            </div>
                        </asp:Panel>
                        <asp:Panel ID="pnl_gyanlis"  runat="server">
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

    </section>
</asp:Content>
