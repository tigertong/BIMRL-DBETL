﻿using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;
using NetSdoGeometry;
using BIMRL;
using BIMRLInterface;
using BIMRL.OctreeLib;
using Newtonsoft.Json;

namespace BIMRLInterface.ExtensionFunction
{
    public class SmallestRectangularEdge : ExtensionFunctionBase, IBIMRLExtensionFunction
    {
        public SmallestRectangularEdge()
        {

        }

        /// <summary>
        /// GetCoordinates function
        /// </summary>
        /// <param name="inputDT"></param>
        /// <param name="inputParams"></param>
        public override void InvokeRule(DataTable inputDT, params string[] inputParams)
        {
            base.InvokeRule(inputDT,inputParams);

            DataColumn column = new DataColumn();
            column.DataType = System.Type.GetType("System.Double");
            column.ColumnName = "OUTPUT";
            column.ReadOnly = false;
            column.Unique = false;
            try
            {
                inputDT.Columns.Add(column);    // Add column result
            }
            catch (System.Data.DuplicateNameException)
            {
                // ignore error for duplicate column and continue
            }

            foreach (DataRow row in inputDT.Rows)
            {
                SdoGeometry geom = row[inputParams[0]] as SdoGeometry;
                if (geom == null)
                    continue;

                Face3D fGeom;
                if (SDOGeomUtils.generate_Face3D(geom, out fGeom))
                {
                    if (!geomIsRectangular(fGeom))
                        continue;

                    double minSegment = double.MaxValue;
                    foreach(LineSegment3D segment in fGeom.boundaries)
                    {
                        if (segment.extent < minSegment)
                            minSegment = segment.extent;
                    }
                    row["OUTPUT"] = minSegment;
                }
            }
            m_Result = inputDT;
        }

        bool geomIsRectangular(Face3D f)
        {
            if (f.boundaries.Count > 4)
                return false;           // more than 4 edges, most probably not rectangle

            LineSegment3D nextSegment;
            for (int lCnt = 0; lCnt < f.boundaries.Count; ++lCnt)
            {
                if (lCnt == f.boundaries.Count - 1)
                {
                    // The last segment
                    nextSegment = f.boundaries[0];
                }
                else
                    nextSegment = f.boundaries[lCnt + 1];

                double dotProdRes = Vector3D.DotProduct(f.boundaries[lCnt].unNormalizedVector, nextSegment.unNormalizedVector);
                if (dotProdRes >= 0.000001 || dotProdRes <= -.000001)
                {
                    return false;   // 2 segments are not perpendicular
                }
            }
            return true;
        }
    }
}
