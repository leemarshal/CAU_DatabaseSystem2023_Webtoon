'use client'
import ComicIcon from "@/app/icons/ComicIcon";

export default function CookiePurchaseItem(props:any) {
    return (
        <div style={{
            border: "2px solid #00000040",
            borderRadius: 10,
            margin: "14px 20px",
            background:"white",
            padding: "10px 14px",
            cursor:"pointer"
        }} onClick={props.onClick}>
            <div style={{display: "flex", alignItems: "center"}}>
                <ComicIcon/>
                <span style={{fontSize: 24, fontWeight: 600, marginLeft: 10}}>{props.cookies}개</span>
                {!!props.desc && <span style={{fontSize: 18, fontWeight: 600, marginLeft: 8}}>- {props.desc}</span>}
            </div>
            <div style={{fontSize: 16, fontWeight: 600, textAlign: "right"}}>{props.price}원</div>
        </div>
    )
}