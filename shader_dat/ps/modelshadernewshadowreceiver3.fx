sampler Shadow_Tex_sampler : register(s11);
float4 g_CameraParam : register(c193);
float4 g_CastTexSize : register(c189);
float4x4 g_IView : register(c12);
float4 g_ShadowFarInv : register(c184);
float4 g_ShadowForWin : register(c185);
float4x4 g_ShadowView : register(c32);
float4x4 g_ShadowViewProj : register(c28);
float4x4 g_ViewProjection : register(c8);
sampler g_Z_sampler : register(s6);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	float4 r5;
	float4 r6;
	r0 = tex2D(g_Z_sampler, i.texcoord);
	r0.z = r0.x * g_CameraParam.y + g_CameraParam.x;
	o.xyw = r0.xyx * float3(1, 1, 0) + 0;
	r0.xy = r0.zz * i.texcoord1.xy;
	r1.z = -r0.z;
	r1.xy = r0.xy * i.texcoord1.zw;
	r1.w = 1;
	r0.x = dot(r1, transpose(g_IView)[0]);
	r0.y = dot(r1, transpose(g_IView)[1]);
	r0.z = dot(r1, transpose(g_IView)[2]);
	r0.w = dot(r1, transpose(g_IView)[3]);
	r1.x = dot(r0, transpose(g_ViewProjection)[3]);
	r1.x = 1 / r1.x;
	r1.y = dot(r0, transpose(g_ViewProjection)[2]);
	r2 = r1.y * r1.x + -g_ShadowFarInv.y;
	r1 = r1.y * -r1.x + g_ShadowFarInv.z;
	clip(r1);
	clip(r2);
	r1.x = dot(r0, transpose(g_ShadowView)[2]);
	r1 = -r1.x;
	clip(r1);
	r1.x = dot(r0, transpose(g_ShadowViewProj)[0]);
	r2.w = dot(r0, transpose(g_ShadowViewProj)[3]);
	r1.z = 1 / r2.w;
	r1.w = r1.x * r1.z + 1;
	r3 = r1.w * 0.5 + -0.001;
	r4 = r1.w * -0.5 + 0.999;
	r1.w = r3.w;
	clip(r3);
	r1.y = dot(r0, transpose(g_ShadowViewProj)[1]);
	r0.x = dot(r0, transpose(g_ShadowViewProj)[2]);
	r2.z = r0.x + -g_ShadowForWin.y;
	r0.x = r1.y * -r1.z + 1;
	r0.yz = r1.zz * r1.xy;
	r2.xy = r0.yz * float2(0.5, -0.5) + 0.5;
	r3 = r0.x * 0.5 + -0.001;
	r0 = r0.x * -0.5 + 0.999;
	r1.x = r3.w;
	clip(r3);
	r1.y = r4.w;
	clip(r4);
	r1.z = r0.w;
	clip(r0);
	r0.zw = r2.zw;
	r3.yw = 0;
	r4.x = 1 / g_CastTexSize.z;
	r4.x = r4.x * g_ShadowForWin.z;
	r3.xz = r4.xx * float2(1.5, -0.5);
	r0.xy = r2.xy + r3.xy;
	r3.xy = r2.xy + r3.zw;
	r5 = tex2D(Shadow_Tex_sampler, r0);
	r3.zw = r0.zw;
	r0 = tex2D(Shadow_Tex_sampler, r2);
	r0.x = r5.x * 0.8 + r0.x;
	r5 = tex2D(Shadow_Tex_sampler, r3);
	r0.x = r5.x * 0.45 + r0.x;
	r5.yw = 0;
	r5.xz = r4.xx * float2(-1.5, 0.5);
	r3.xy = r2.xy + r5.xy;
	r5.xy = r2.xy + r5.zw;
	r6 = tex2D(Shadow_Tex_sampler, r3);
	r5.zw = r3.zw;
	r3 = tex2D(Shadow_Tex_sampler, r5);
	r0.x = r6.x * 0.8 + r0.x;
	r0.x = r3.x * 0.45 + r0.x;
	r3.xzw = r2.xzw;
	r3.y = r4.x * 1.5 + r2.y;
	r5 = tex2D(Shadow_Tex_sampler, r3);
	r0.x = r5.x * 0.8 + r0.x;
	r5.xzw = r3.xzw;
	r5.y = r4.x * 2.5 + r2.y;
	r5 = tex2D(Shadow_Tex_sampler, r5);
	r0.x = r5.x * 0.45 + r0.x;
	r5.xzw = r3.xzw;
	r5.y = r4.x * -1.5 + r2.y;
	r3.y = r4.x * -2.5 + r2.y;
	r4 = tex2D(Shadow_Tex_sampler, r3);
	r5 = tex2D(Shadow_Tex_sampler, r5);
	r0.x = r5.x * 0.8 + r0.x;
	r0.x = r4.x * 0.45 + r0.x;
	r0.w = 0.00036621094;
	r3.xy = g_ShadowForWin.zz * r0.ww + r2.xy;
	r4 = tex2D(Shadow_Tex_sampler, r3);
	r0.x = r4.x * 0.8 + r0.x;
	r0.z = g_ShadowForWin.z;
	r3.xy = r0.zz * 0.00061035156 + r2.xy;
	r4 = tex2D(Shadow_Tex_sampler, r3);
	r0.x = r4.x * 0.45 + r0.x;
	r3.xy = g_ShadowForWin.zz * -r0.ww + r2.xy;
	r4 = tex2D(Shadow_Tex_sampler, r3);
	r0.x = r4.x * 0.8 + r0.x;
	r3.xy = r0.zz * -0.00061035156 + r2.xy;
	r4 = tex2D(Shadow_Tex_sampler, r3);
	r0.x = r4.x * 0.45 + r0.x;
	r3.xy = r0.zz * float2(-0.00036621094, 0.00036621094) + r2.xy;
	r4 = tex2D(Shadow_Tex_sampler, r3);
	r0.x = r4.x * 0.8 + r0.x;
	r3.xy = r0.zz * float2(-0.00061035156, 0.00061035156) + r2.xy;
	r4 = tex2D(Shadow_Tex_sampler, r3);
	r0.x = r4.x * 0.45 + r0.x;
	r3.xy = r0.zz * float2(0.00036621094, -0.00036621094) + r2.xy;
	r2.xy = r0.zz * float2(0.00061035156, -0.00061035156) + r2.xy;
	r4 = tex2D(Shadow_Tex_sampler, r3);
	r2.zw = r3.zw;
	r2 = tex2D(Shadow_Tex_sampler, r2);
	r0.x = r4.x * 0.8 + r0.x;
	r0.x = r2.x * 0.45 + r0.x;
	r0.y = frac(-r1.w);
	r0.y = r0.y + r1.w;
	r0.y = -r0.y + 1;
	r1.w = max(r0.y, 0);
	r0.x = r0.x * 0.09090909 + r1.w;
	r0.y = frac(-r1.y);
	r0.y = r0.y + r1.y;
	r0.y = -r0.y + 1;
	r1.y = max(r0.y, 0);
	r0.x = r0.x + r1.y;
	r0.y = frac(-r1.z);
	r0.y = r0.y + r1.z;
	r0.y = -r0.y + 1;
	r1.y = max(r0.y, 0);
	r0.x = r0.x + r1.y;
	r0.y = frac(-r1.x);
	r0.y = r0.y + r1.x;
	r0.y = -r0.y + 1;
	r1.x = max(r0.y, 0);
	o.z = r0.x + r1.x;

	return o;
}
