using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eBike.Data.POCOs;
using eBikeSystem.DAL;
using eBike.Data.DTOs;
using eBike.Data.Entities;

namespace eBikeSystem.BLL
{
    [DataObject]
    public class ReceivingController
    {
        [DataObjectMethod(DataObjectMethodType.Select, false)]

        public List<OutstandingOrdersPOCO>GetOutstandingPO()
        {
            using (var context = new eBikeContext())
            { 
                var results = from po in context.PurchaseOrders
                              where po.Closed == false && po.OrderDate.HasValue && po.PurchaseOrderNumber.HasValue
                              select new OutstandingOrdersPOCO
                              {
                                  PurchaseOrderID = po.PurchaseOrderID,
                                  PurchaseOrderNumber = po.PurchaseOrderNumber,
                                  OrderDate = po.OrderDate,
                                  Vendor = po.Vendor.VendorName,
                                  Phone = po.Vendor.Phone
                              };
                return results.ToList();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]

        public VendorPurchaseOrderDetailsDTO GetPODetails(int poID)
        {        
            using (var context = new eBikeContext())
            {
                VendorPurchaseOrderDetailsDTO vendorPODetails = new VendorPurchaseOrderDetailsDTO();
                List<PurchaseOrderDetailsPOCO> poDetails = new List<PurchaseOrderDetailsPOCO>();              

                var poResults = from pod in context.PurchaseOrderDetails
                                orderby pod.PartID ascending
                                where pod.PurchaseOrderID.Equals(poID)
                                select new PurchaseOrderDetailsPOCO
                                {
                                    PurchaseOrderID = pod.PurchaseOrderID,
                                    PartID = pod.PartID,
                                    Description = pod.Part.Description,
                                    QuantityOnOrder = pod.Part.QuantityOnOrder,
                                    QuantityOutstanding = pod.ReceiveOrderDetails.Select(rod => rod.QuantityReceived).Any() ? pod.Quantity - pod.ReceiveOrderDetails.Sum(rod => rod.QuantityReceived) : pod.Quantity,
                                };
                poDetails = poResults.ToList();

                var vendorResults = (from po in context.PurchaseOrders
                                    where po.PurchaseOrderID.Equals(poID)
                                    select new
                                    {
                                        poNum = po.PurchaseOrderNumber,
                                        Phone = po.Vendor.Phone,
                                        Name = po.Vendor.VendorName
                                    }).FirstOrDefault();  //return first record from return result(using it when have only one item to return) 

                vendorPODetails.PurchaseOrderNumber = vendorResults.poNum;
                vendorPODetails.VendorPhone = vendorResults.Phone;
                vendorPODetails.VendorName = vendorResults.Name;

                vendorPODetails.PODetails = poDetails;

                return vendorPODetails;
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<UnorderedPurchaseItemCart>GetUnorderedVendorParts()
        {
            using (var context = new eBikeContext())
            {
                var results = from upic in context.UnorderedPurchaseItemCarts
                              select new UnorderedPurchaseItemCart
                              {
                                  CartID = upic.CartID,
                                  PurchaseOrderNumber = upic.PurchaseOrderNumber,
                                  VendorPartNumber = upic.VendorPartNumber,
                                  Description = upic.Description,
                                  Quantity = upic.Quantity
                              };
                return results.ToList();
            }
        } 
    }
}
