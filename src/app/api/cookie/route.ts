import { userFromToken } from "@/func/userFromToken";
import { PrismaClient } from "@prisma/client";
import { cookies } from "next/headers";
import { NextRequest, NextResponse } from "next/server";

export async function GET(request: NextRequest) {
  const token = cookies().get("token")?.value;
  if (!token) return NextResponse.json("No token", { status: 403 });

  const user = await userFromToken(token);
  const prisma = new PrismaClient();
  const reader = await prisma.readers.findFirst({
    where: { ReaderID: user?.UserID },
  });

  prisma.$disconnect();
  if (!reader) return NextResponse.json("No reader", { status: 403 });
  return NextResponse.json(reader.CookieAmount);
}

export async function POST(request: NextRequest) {
  let body: {
    cookies: number;
    price: number;
    desc: string;
  };
  try {
    body = await request.json();
  } catch (e) {
    return NextResponse.json("No info in body", { status: 403 });
  }

  const token = cookies().get("token")?.value;
  if (!token) return NextResponse.json("No token", { status: 403 });

  const user = await userFromToken(token);
  if (!user) return NextResponse.json("No User", { status: 403 });

  const prisma = new PrismaClient();

  const payMethod = await prisma.readerPaymentMethods.findFirst({
    where: {
      ReaderID: user.UserID,
    },
  });
  if (!payMethod)
    return NextResponse.json("No Payment Method", { status: 400 });

  console.log(payMethod.ReaderPaymentMethodID);
  await prisma.readerCookiePurchases.create({
    data: {
      ReaderID: user.UserID,
      Amount: body.cookies,
      Date: new Date(),
      ReaderPaymentMethodID: payMethod.ReaderPaymentMethodID,
    },
  });
  prisma.$disconnect;

  return NextResponse.json("success");
}
