'use client'
import {useRouter} from "next/navigation";

export default function ComicItem({image = "", title = "", path = "", width = "auto"}) {
    const router = useRouter()

    return (
        <div
            style={{
                display: "inline-block", padding: "1% 3% 1% 3%", width: width, cursor: "pointer"
            }}
            onClick={() => router.push(path)}>
            <img src={image}
                 style={{width: "100%", height: "100%", aspectRatio: 1, objectFit: "cover", borderRadius: 10}}/>
            <div style={{textAlign: "center", margin: "8px 0 4px 0", color: "black"}}>{title}</div>
        </div>
    )
}