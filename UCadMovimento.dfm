object MovimentoForm: TMovimentoForm
  Left = 0
  Top = 0
  Caption = 'Movimento'
  ClientHeight = 467
  ClientWidth = 984
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object TanquesPanel: TPanel
    Left = 0
    Top = 0
    Width = 984
    Height = 153
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 6
      Width = 20
      Height = 15
      Caption = 'De: '
    end
    object Label2: TLabel
      Left = 110
      Top = 32
      Width = 18
      Height = 15
      Caption = 'At'#233
    end
    object Label3: TLabel
      Left = 16
      Top = 53
      Width = 41
      Height = 15
      Caption = 'Tanque:'
    end
    object Label4: TLabel
      Left = 16
      Top = 101
      Width = 41
      Height = 15
      Caption = 'Bomba:'
    end
    object DeletarButton: TButton
      Left = 594
      Top = 97
      Width = 121
      Height = 25
      Caption = '&Consultar'
      TabOrder = 0
      OnClick = DeletarButtonClick
    end
    object InicialDateTimePicker: TDateTimePicker
      Left = 15
      Top = 24
      Width = 89
      Height = 23
      Date = 45376.000000000000000000
      Time = 0.890983645833330200
      TabOrder = 1
    end
    object FinalDateTimePicker: TDateTimePicker
      Left = 136
      Top = 24
      Width = 89
      Height = 23
      Date = 45376.000000000000000000
      Time = 0.890983645833330200
      TabOrder = 2
    end
    object TanqueDBLookupComboBox: TDBLookupComboBox
      Left = 16
      Top = 72
      Width = 145
      Height = 23
      KeyField = 'COD_TANQUE'
      ListField = 'DESCRICAO'
      ListSource = TanqueDataSource
      TabOrder = 3
    end
    object BombasDBLookupComboBox: TDBLookupComboBox
      Left = 16
      Top = 122
      Width = 145
      Height = 23
      KeyField = 'COD_BOMBA'
      ListField = 'DESCRICAO'
      ListSource = BombaDataSource
      TabOrder = 4
    end
    object LimparCamposButton: TButton
      Left = 721
      Top = 97
      Width = 121
      Height = 25
      Caption = '&Limpar Filtros'
      TabOrder = 5
      OnClick = LimparCamposButtonClick
    end
    object ImprimirButton: TButton
      Left = 848
      Top = 97
      Width = 121
      Height = 25
      Caption = '&Imprimir'
      TabOrder = 6
      OnClick = ImprimirButtonClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 153
    Width = 985
    Height = 312
    Align = alCustom
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object TanquesDBGrid: TDBGrid
      Left = 0
      Top = 0
      Width = 985
      Height = 312
      Align = alCustom
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = MovimentoDataSource
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'COD_BOMBA'
          Title.Caption = 'C'#243'd. Bomba'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOME_BOMBA'
          Title.Caption = 'Descri'#231#227'o'
          Width = 248
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COD_TANQUE'
          Title.Caption = 'C'#243'd. Tanque'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOME_TANQUE'
          Title.Caption = 'Nome Tanque'
          Width = 243
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TIPO'
          Title.Caption = 'Combust'#237'vel'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TOTAL_LITROS'
          Title.Caption = 'Total de Litros'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR_TOTAL'
          Title.Caption = 'Valor Total'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA_ABASTECIMENTO'
          Title.Caption = 'Data Abastecimento'
          Visible = True
        end>
    end
  end
  object MovimentoFDQuery: TFDQuery
    Connection = FrmPrincipal.FDConnection
    SQL.Strings = (
      
        'SELECT BOM.cod_bomba, BOM.descricao AS NOME_BOMBA, TAN.cod_tanqu' +
        'e, TAN.descricao AS NOME_TANQUE, CASE WHEN TAN.tipo = 0 THEN '#39'Ga' +
        'solina'#39' WHEN TAN.tipo = 1 THEN '#39'Diesel'#39' ELSE '#39'Etanol'#39' end AS Tip' +
        'o,'
      
        '  sum(ABA.valor_total) AS valor_total, SUM(ABA.total_litros) AS ' +
        'total_litros, DATA_ABASTECIMENTO'
      '   FROM ABASTECIMENTOS ABA'
      '   JOIN BOMBAS  BOM ON (BOM.COD_BOMBA = ABA.COD_BOMBA)'
      '   JOIN  TANQUES TAN ON (TAN.COD_TANQUE = ABA.COD_TANQUE)'
      
        'group by DATA_ABASTECIMENTO,BOM.cod_bomba,TAN.cod_tanque,TAN.tip' +
        'o, BOM.descricao, TAN.descricao')
    Left = 312
    Top = 16
    object MovimentoFDQueryCOD_BOMBA: TIntegerField
      FieldName = 'COD_BOMBA'
      Origin = 'COD_BOMBA'
      Required = True
    end
    object MovimentoFDQueryNOME_BOMBA: TStringField
      FieldName = 'NOME_BOMBA'
      Origin = 'NOME_BOMBA'
      Size = 150
    end
    object MovimentoFDQueryCOD_TANQUE: TIntegerField
      FieldName = 'COD_TANQUE'
      Origin = 'COD_TANQUE'
      Required = True
    end
    object MovimentoFDQueryNOME_TANQUE: TStringField
      FieldName = 'NOME_TANQUE'
      Origin = 'NOME_TANQUE'
      Size = 150
    end
    object MovimentoFDQueryTIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'TIPO'
      Required = True
      FixedChar = True
      Size = 8
    end
    object MovimentoFDQueryVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Origin = 'VALOR_TOTAL'
      currency = True
      Precision = 18
      Size = 2
    end
    object MovimentoFDQueryTOTAL_LITROS: TFMTBCDField
      FieldName = 'TOTAL_LITROS'
      Origin = 'TOTAL_LITROS'
      DisplayFormat = '###0.000'
      Precision = 18
      Size = 3
    end
    object MovimentoFDQueryDATA_ABASTECIMENTO: TDateField
      Alignment = taCenter
      FieldName = 'DATA_ABASTECIMENTO'
      Origin = 'DATA_ABASTECIMENTO'
    end
  end
  object MovimentoDataSource: TDataSource
    DataSet = MovimentoFDQuery
    Left = 368
    Top = 16
  end
  object TanqueFDQuery: TFDQuery
    Connection = FrmPrincipal.FDConnection
    SQL.Strings = (
      
        'SELECT 999 AS  COD_TANQUE, '#39'TODOS'#39' AS DESCRICAO FROM rdb$databas' +
        'e'
      'UNION ALL'
      'SELECT COD_TANQUE, DESCRICAO FROM TANQUES')
    Left = 304
    Top = 80
    object TanqueFDQueryCOD_TANQUE: TIntegerField
      FieldName = 'COD_TANQUE'
      Origin = 'COD_TANQUE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TanqueFDQueryDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 150
    end
  end
  object TanqueDataSource: TDataSource
    DataSet = TanqueFDQuery
    Left = 360
    Top = 80
  end
  object BombaFDQuery: TFDQuery
    Connection = FrmPrincipal.FDConnection
    SQL.Strings = (
      'SELECT 999 AS  COD_BOMBA, '#39'TODOS'#39' AS DESCRICAO FROM rdb$database'
      'UNION ALL'
      'SELECT COD_BOMBA, DESCRICAO FROM BOMBAS')
    Left = 440
    Top = 64
    object BombaFDQueryCOD_BOMBA: TIntegerField
      FieldName = 'COD_BOMBA'
      Origin = 'COD_BOMBA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object BombaFDQueryDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 150
    end
  end
  object BombaDataSource: TDataSource
    DataSet = BombaFDQuery
    Left = 512
    Top = 56
  end
  object TotaisFDQuery: TFDQuery
    Connection = FrmPrincipal.FDConnection
    SQL.Strings = (
      
        'SELECT SUM(ABA.total_litros) AS total_litros,SUM(ABA.valor_total' +
        ') AS valor_total,DATA_ABASTECIMENTO'
      '   FROM ABASTECIMENTOS ABA'
      '   JOIN BOMBAS  BOM ON (BOM.COD_BOMBA = ABA.COD_BOMBA)'
      '   JOIN  TANQUES TAN ON (TAN.COD_TANQUE = ABA.COD_TANQUE)'
      'group by DATA_ABASTECIMENTO')
    Left = 664
    Top = 16
    object TotaisFDQueryTOTAL_LITROS: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'TOTAL_LITROS'
      Origin = 'TOTAL_LITROS'
      ProviderFlags = []
      ReadOnly = True
      Precision = 18
      Size = 3
    end
    object TotaisFDQueryVALOR_TOTAL: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'VALOR_TOTAL'
      Origin = 'VALOR_TOTAL'
      ProviderFlags = []
      ReadOnly = True
      Precision = 18
      Size = 2
    end
    object TotaisFDQueryDATA_ABASTECIMENTO: TDateField
      FieldName = 'DATA_ABASTECIMENTO'
      Origin = 'DATA_ABASTECIMENTO'
    end
  end
  object TotaisDataSource: TDataSource
    DataSet = TotaisFDQuery
    Left = 744
    Top = 16
  end
end
