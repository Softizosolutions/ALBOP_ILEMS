using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Data;
using System.Text;

namespace Licensing.Prints
{
    public static class Excel
    {
        //Row limits older excel verion per sheet, the row limit for excel 2003 is 65536
        const int rowLimit = 65000;

        private static string getWorkbookTemplate()
        {
            var sb = new StringBuilder(818);
            sb.AppendFormat(@"<?xml version=""1.0""?>{0}", Environment.NewLine);
            sb.AppendFormat(@"<?mso-application progid=""Excel.Sheet""?>{0}", Environment.NewLine);
            sb.AppendFormat(@"<Workbook xmlns=""urn:schemas-microsoft-com:office:spreadsheet""{0}", Environment.NewLine);
            sb.AppendFormat(@" xmlns:o=""urn:schemas-microsoft-com:office:office""{0}", Environment.NewLine);
            sb.AppendFormat(@" xmlns:x=""urn:schemas-microsoft-com:office:excel""{0}", Environment.NewLine);
            sb.AppendFormat(@" xmlns:ss=""urn:schemas-microsoft-com:office:spreadsheet""{0}", Environment.NewLine);
            sb.AppendFormat(@" xmlns:html=""http://www.w3.org/TR/REC-html40"">{0}", Environment.NewLine);
            sb.AppendFormat(@" <Styles>{0}", Environment.NewLine);
            sb.AppendFormat(@"  <Style ss:ID=""Default"" ss:Name=""Normal"">{0}", Environment.NewLine);
            sb.AppendFormat(@"   <Alignment ss:Vertical=""Bottom""/>{0}", Environment.NewLine);
            sb.AppendFormat(@"   <Borders/>{0}", Environment.NewLine);
            sb.AppendFormat(@"   <Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Size=""11"" ss:Color=""#000000""/>{0}", Environment.NewLine);
            sb.AppendFormat(@"   <Interior/>{0}", Environment.NewLine);
            sb.AppendFormat(@"   <NumberFormat/>{0}", Environment.NewLine);
            sb.AppendFormat(@"   <Protection/>{0}", Environment.NewLine);
            sb.AppendFormat(@"  </Style>{0}", Environment.NewLine);
            sb.AppendFormat(@"    <Style ss:ID=""s92"">{0}", Environment.NewLine);
            sb.AppendFormat(@" <Borders>{0}", Environment.NewLine);
            sb.AppendFormat(@" <Border ss:Position=""Bottom"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>{0}", Environment.NewLine);
            sb.AppendFormat(@" <Border ss:Position=""Left"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>{0}", Environment.NewLine);
            sb.AppendFormat(@" <Border ss:Position=""Right"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>{0}", Environment.NewLine);
            sb.AppendFormat(@" <Border ss:Position=""Top"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>{0}", Environment.NewLine);
            sb.AppendFormat(@" </Borders>{0}", Environment.NewLine);
            sb.AppendFormat(@" <Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Size=""11"" ss:Color=""#000000""{0}", Environment.NewLine);
            sb.AppendFormat(@" ss:Bold=""1""/>{0}", Environment.NewLine);
            sb.AppendFormat(@" <Interior ss:Color=""#FDE9D9"" ss:Pattern=""Solid""/>{0}", Environment.NewLine);
            sb.AppendFormat(@" </Style>{0}", Environment.NewLine);
            sb.AppendFormat(@" <Style ss:ID=""s93"">{0}", Environment.NewLine);
            sb.AppendFormat(@" <Borders>{0}", Environment.NewLine);
            sb.AppendFormat(@" <Border ss:Position=""Bottom"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>{0}", Environment.NewLine);
            sb.AppendFormat(@" <Border ss:Position=""Left"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>{0}", Environment.NewLine);
            sb.AppendFormat(@" <Border ss:Position=""Right"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>{0}", Environment.NewLine);
            sb.AppendFormat(@" <Border ss:Position=""Top"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>{0}", Environment.NewLine);
            sb.AppendFormat(@" </Borders>{0}", Environment.NewLine);
            sb.AppendFormat(@" </Style>{0}", Environment.NewLine);
            sb.AppendFormat(@" <Style ss:ID=""s97"">{0}", Environment.NewLine);
            sb.AppendFormat(@" <Borders>{0}", Environment.NewLine);
            sb.AppendFormat(@" <Border ss:Position=""Bottom"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>{0}", Environment.NewLine);
            sb.AppendFormat(@" <Border ss:Position=""Left"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>{0}", Environment.NewLine);
            sb.AppendFormat(@" <Border ss:Position=""Right"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>{0}", Environment.NewLine);
            sb.AppendFormat(@" <Border ss:Position=""Top"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>{0}", Environment.NewLine);
            sb.AppendFormat(@" </Borders>{0}", Environment.NewLine);
            sb.AppendFormat(@" <Interior ss:Color=""#F2F2F2"" ss:Pattern=""Solid""/>{0}", Environment.NewLine);
            sb.AppendFormat(@" </Style>{0}", Environment.NewLine);
            sb.AppendFormat(@"    <Style ss:ID=""s77"">{0}", Environment.NewLine);
            sb.AppendFormat(@"   <Alignment ss:Horizontal=""Center"" ss:Vertical=""Center""/>{0}", Environment.NewLine);
            sb.AppendFormat(@" <Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Size=""14"" ss:Color=""#974807""{0}", Environment.NewLine);
            sb.AppendFormat(@"    ss:Bold=""1""/>{0}", Environment.NewLine);
            sb.AppendFormat(@"  </Style>{0}", Environment.NewLine);
            sb.AppendFormat(@"  <Style ss:ID=""s62"">{0}", Environment.NewLine);
            sb.AppendFormat(@"   <Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Size=""11"" ss:Color=""#000000""{0}", Environment.NewLine);
            sb.AppendFormat(@"    ss:Bold=""1""/>{0}", Environment.NewLine);
            sb.AppendFormat(@"  </Style>{0}", Environment.NewLine);
            sb.AppendFormat(@"  <Style ss:ID=""s63"">{0}", Environment.NewLine);
            sb.AppendFormat(@"   <NumberFormat ss:Format=""Short Date""/>{0}", Environment.NewLine);
            sb.AppendFormat(@"  </Style>{0}", Environment.NewLine);
            sb.AppendFormat(@" </Styles>{0}", Environment.NewLine);
            sb.Append(@"{0}\r\n</Workbook>");
            return sb.ToString();
        }


        private static string replaceXmlChar(string input)
        {
            input = input.Replace("&", "&amp");
            input = input.Replace("<", "&lt;");
            input = input.Replace(">", "&gt;");
            input = input.Replace("\"", "&quot;");
            input = input.Replace("'", "&apos;");
            return input;
        }

        private static string getCell(Type type, object cellData, int i)
        {
            var data = (cellData is DBNull) ? "" : cellData;
            if (type.Name.Contains("Int") || type.Name.Contains("Double") || type.Name.Contains("Decimal")) return string.Format("<Cell><Data ss:Type=\"Number\">{0}</Data></Cell>", data);
            if (type.Name.Contains("Date") && data.ToString() != string.Empty)
            {
                if (i % 3 == 0)
                    return string.Format("<Cell ss:StyleID=\"s93\"><Data ss:Type=\"DateTime\">{0}</Data></Cell>", Convert.ToDateTime(data).ToString("yyyy-MM-dd"));
                else
                    return string.Format("<Cell ss:StyleID=\"s97\"><Data ss:Type=\"DateTime\">{0}</Data></Cell>", Convert.ToDateTime(data).ToString("yyyy-MM-dd"));
            }
            if (i % 2 == 0)
                return string.Format("<Cell ss:StyleID=\"s93\"><Data ss:Type=\"String\">{0}</Data></Cell>", replaceXmlChar(data.ToString()));
            else
                return string.Format("<Cell ss:StyleID=\"s97\"><Data ss:Type=\"String\">{0}</Data></Cell>", replaceXmlChar(data.ToString()));
        }
        private static string getWorksheets(DataSet source, string rhead)
        {
            var sw = new StringWriter();
            if (source == null || source.Tables.Count == 0)
            {
                sw.Write("<Worksheet ss:Name=\"Sheet1\">\r\n<Table>\r\n<Row><Cell><Data ss:Type=\"String\"></Data></Cell></Row>\r\n</Table>\r\n</Worksheet>");
                return sw.ToString();
            }
            foreach (DataTable dt in source.Tables)
            {
                if (dt.Rows.Count == 0)
                    sw.Write("<Worksheet ss:Name=\"" + replaceXmlChar(dt.TableName) + "\">\r\n<Table>\r\n<Row><Cell  ss:StyleID=\"s62\"><Data ss:Type=\"String\"></Data></Cell></Row>\r\n</Table>\r\n</Worksheet>");
                else
                {
                    //write each row data                
                    var sheetCount = 0;
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if ((i % rowLimit) == 0)
                        {
                            //add close tags for previous sheet of the same data table
                            if ((i / rowLimit) > sheetCount)
                            {
                                sw.Write("\r\n</Table>\r\n</Worksheet>");
                                sheetCount = (i / rowLimit);
                            }

                            sw.Write("\r\n<Worksheet ss:Name=\"" + replaceXmlChar(dt.TableName) +
                                     (((i / rowLimit) == 0) ? "" : Convert.ToString(i / rowLimit)) + "\">\r\n<Table>");
                            //write column name row
                            foreach (DataColumn dc in dt.Columns)
                                sw.Write("<Column ss:AutoFitWidth='0' ss:Width='130.25'/>\r\n");
                            sw.Write("\r\n<Row>");

                            sw.Write(string.Format("<Cell ss:MergeAcross='" + dt.Columns.Count.ToString() + "' ss:StyleID=\"s77\"><Data ss:Type=\"String\">{0}</Data></Cell>", replaceXmlChar(rhead)));
                            sw.Write("</Row>");
                            sw.Write("\r\n<Row>");

                            foreach (DataColumn dc in dt.Columns)
                                sw.Write(string.Format("<Cell ss:StyleID=\"s92\"><Data ss:Type=\"String\">{0}</Data></Cell>", replaceXmlChar(dc.ColumnName)));
                            sw.Write("</Row>");
                        }
                        sw.Write("\r\n<Row>");
                        foreach (DataColumn dc in dt.Columns)
                            sw.Write(getCell(dc.DataType, dt.Rows[i][dc.ColumnName], i));
                        sw.Write("</Row>");
                    }
                    sw.Write("\r\n</Table>\r\n</Worksheet>");
                }
            }

            return sw.ToString();
        }
        public static string GetExcelXml(DataTable dtInput, string filename, string rhead)
        {
            var excelTemplate = getWorkbookTemplate();
            var ds = new DataSet();
            ds.Tables.Add(dtInput.Copy());
            var worksheets = getWorksheets(ds, rhead);
            var excelXml = string.Format(excelTemplate, worksheets);
            return excelXml;
        }

        public static string GetExcelXml(DataSet dsInput, string filename, string rhead)
        {
            var excelTemplate = getWorkbookTemplate();
            var worksheets = getWorksheets(dsInput, rhead);
            var excelXml = string.Format(excelTemplate, worksheets);
            return excelXml;
        }

        public static void ToExcel(DataSet dsInput, string filename, HttpResponse response, string rhead)
        {
            var excelXml = GetExcelXml(dsInput, filename, rhead);
            response.Clear();
            response.AppendHeader("Content-Type", "application/vnd.ms-excel");
            response.AppendHeader("Content-disposition", "attachment; filename=" + filename);
            response.Write(excelXml);
            response.Flush();
            response.End();
        }

        public static void ToExcel(DataTable dtInput, string filename, HttpResponse response, string rhead)
        {
            var ds = new DataSet();
            ds.Tables.Add(dtInput.Copy());
            ToExcel(ds, filename, response, rhead);
        }
   
    }
}