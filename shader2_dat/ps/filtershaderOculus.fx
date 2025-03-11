float4 g_CenterParam : register(c184);
float4 g_ChromaticAberration : register(c187);
sampler g_Sampler : register(s0);
float4 g_ScaleParam : register(c185);
float4 g_WarpParam : register(c186);
float4 g_uvHosei : register(c188);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	r0.xy = -g_CenterParam.xy + texcoord.xy;
	r0.xy = r0.xy * g_ScaleParam.zw;
	r0.z = dot(r0.z, r0.z) + 0;
	r0.w = g_WarpParam.y * r0.z + g_WarpParam.x;
	r1.x = r0.z * r0.z;
	r0.w = r1.x * g_WarpParam.z + r0.w;
	r1.x = r1.x * g_WarpParam.w;
	r0.w = r1.x * r0.z + r0.w;
	r1 = g_ChromaticAberration.wwyy * r0.z + g_ChromaticAberration.zzxx;
	r0.xy = r0.ww * r0.xy;
	r2 = g_CenterParam;
	r0.zw = g_ScaleParam.xy * r0.xy + r2.xy;
	r1 = r1 * r0.xyxy;
	r1 = g_ScaleParam.xyxy * r1 + r2.xyxy;
	r0.xy = r0.zw + g_uvHosei.zw;
	r0.xy = r0.xy * g_uvHosei.xy;
	r0 = tex2D(g_Sampler, r0);
	r3 = r1 + g_uvHosei.zwzw;
	r3 = r3 * g_uvHosei.xyxy;
	r4 = tex2D(g_Sampler, r3.zwzw);
	r3 = tex2D(g_Sampler, r3);
	r0.z = r3.z;
	r0.x = r4.x;
	r0.xyz = r0.xyz * 1E-05;
	r2 = r2.zwzw + float4(-0.25, -0.5, 0.25, 0.5);
	r3.xy = max(r1.xy, r2.xy);
	r1.zw = min(r2.zw, r3.xy);
	r1.xy = -r1.xy + r1.zw;
	r0.w = dot(r1.w, r1.w) + 0;
	r0.xyz = (-r0.www >= 0) ? r0.xyz : 0;
	o.xz = r0.xz + 0.5;
	o.y = r0.y;
	o.w = 1;

	return o;
}
