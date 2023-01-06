Shader "Unity Shaders Book/Chapter 5/Simple Shader" {
	Properties {
		_Color ("Color Tint", Color) = (1, 1, 1, 1)
	}
	SubShader {
        Pass {
            CGPROGRAM

			#include "UnityCG.cginc"

            #pragma vertex vert //顶点着色器
            #pragma fragment frag //片元着色器

            uniform fixed4 _Color;

            //a2v means application to vertex shader
			struct a2v {
                float4 vertex : POSITION; //空间坐标
				float3 normal : NORMAL; //法线方向填充normal变量

                float4 texcoord : TEXCOORD0; //纹理坐标
            };

            //a2v means  vertex shader to fragement shader
            struct v2f {
                float4 pos : SV_POSITION;
                fixed3 color : COLOR0;
            };

            //顶点着色器与片元着色器通信，传递变量值
            v2f vert(a2v v) {
            	v2f o;
            	o.pos = UnityObjectToClipPos(v.vertex);
            	o.color = v.normal * 0.5 + fixed3(0.5, 0.5, 0.5);
                return o;
            }

            //片元着色器上色
            fixed4 frag(v2f i) : SV_Target {
            	fixed3 c = i.color;
            	c *= _Color.rgb;
                return fixed4(c, 1.0);
            }

            ENDCG
        }
    }
}
