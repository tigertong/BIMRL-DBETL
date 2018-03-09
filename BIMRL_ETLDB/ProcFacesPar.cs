﻿using System;
using System.Collections.Generic;
using System.Collections.Concurrent;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BIMRL
{
   class ProcFacesPar
   {
      public BIMRLSpatialIndex spIdx;
      public int FedID;
      public string whereCond;
      public ConcurrentBag<TopoFaceRec> TopoFaceRecColl = new ConcurrentBag<TopoFaceRec>();

      public ProcFacesPar(BIMRLSpatialIndex spIdx, int fedID, string where)
      {
         this.spIdx = spIdx;
         this.FedID = fedID;
         this.whereCond = where;
      }
   }
}
