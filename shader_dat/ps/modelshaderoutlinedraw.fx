sampler g_Sampler0 : register(s0);
float4 g_colorEnm : register(c188);
float4 g_colorObj : register(c187);
float4 g_colorScr : register(c189);
float2 g_offset : register(c184);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float3 r1;
	r0.xy = g_offset.xy + texcoord.xy;
	r0 = tex2D(g_Sampler0, r0);
	r1.xyz = r0.yyy * g_colorEnm.xyz;
	r0.xyw = g_colorObj.xyz * r0.xxx + r1.xyz;
	o.xyz = g_colorScr.xyz * r0.zzz + r0.xyw;
	o.w = g_colorObj.w;

	return o;
}
