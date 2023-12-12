"use client";
import ToolBar from "@/app/cookie/components/ToolBar";
import CookiePurchaseItem from "@/app/cookie/components/CookiePurchaseItem";
import { useEffect, useState } from "react";
import { PrismaClient } from "@prisma/client";
import { userFromToken } from "@/func/userFromToken";
import { getCookie } from "cookies-next";
import axios from "axios";
import { useRouter } from "next/navigation";

export default function Cookie() {
  const TOOLBAR_HEIGHT = 70;
  const [isDialogOpen, setDialogOpen] = useState(false);
  const [selectedItem, setSelectedItem] = useState<{
    cookies: number;
    price: number;
    desc: string;
  } | null>(null);
  const [userCookieBalance, setUserCookieBalance] = useState<number | null>(
    null
  );
  const router = useRouter();

  const onClick = async (item: {
    cookies: number;
    price: number;
    desc: string;
  }) => {
    try {
      await axios.post("/api/cookie", item);
      setSelectedItem(item);
      fetchCookieBalance();
      setDialogOpen(true);
    } catch (e) {
      if (axios.isAxiosError(e)) {
        alert(e.message + e.response?.data);
      }
    }
  };

  const fetchCookieBalance = async () => {
    setUserCookieBalance(null);
    const cookie = await axios.get("/api/cookie");
    setUserCookieBalance(Number(cookie.data));
  };

  useEffect(() => {
    fetchCookieBalance();
  }, []);

  const dummyButtons = [
    { cookies: 50, price: 2000, desc: "" },
    { cookies: 100, price: 3500, desc: "" },
    { cookies: 200, price: 6000, desc: "" },
    { cookies: 500, price: 10000, desc: "" },
    { cookies: 2000, price: 30000, desc: "" },
    { cookies: 5000, price: 60000, desc: "최고의 가치" },
  ];

  return (
    <>
      <ToolBar title={"쿠키 구매"} height={TOOLBAR_HEIGHT} />
      <div
        style={{ marginTop: TOOLBAR_HEIGHT, paddingTop: 10, paddingBottom: 40 }}
      >
        <div
          style={{
            textAlign: "center",
            margin: "60px 0 80px",
            fontSize: 20,
            fontWeight: 500,
          }}
        >
          현재 쿠키 :{" "}
          {userCookieBalance ? `${userCookieBalance}개` : `loading...`}
        </div>
        {dummyButtons.map((item, idx) => (
          <CookiePurchaseItem
            key={idx}
            cookies={item.cookies}
            price={item.price}
            desc={item.desc}
            onClick={() => onClick(item)}
          />
        ))}
      </div>
      <div
        style={{
          position: "fixed",
          top: 0,
          left: 0,
          height: "100%",
          width: "100%",
          background: isDialogOpen ? "rgba(0,0,0,0.6)" : "",
          pointerEvents: isDialogOpen ? "all" : "none",
          transition: "background 0.3s",
        }}
        onClick={() => setDialogOpen(false)}
      >
        <div
          style={{
            position: "fixed",
            bottom: isDialogOpen ? 20 : -10,
            opacity: isDialogOpen ? 1 : 0,
            left: 10,
            height: 120,
            width: "calc(100% - 20px)",
            background: "white",
            borderRadius: 10,
            padding: 10,
            boxShadow: "0 2px 10px rgba(0,0,0,0.1)",
            transition: "bottom 0.3s, opacity 0.25s",
            pointerEvents: isDialogOpen ? "all" : "none",
          }}
          onClick={(e) => e.stopPropagation()}
        >
          <div style={{ textAlign: "center", marginTop: 35, fontSize: 18 }}>
            {selectedItem?.price}원 결제되었습니다!
          </div>
        </div>
      </div>
    </>
  );
}
