float4 g_Blur;
float4 g_MatrialColor;
float4 g_Rate;
sampler g_Sampler1;
sampler g_Sampler2;

struct PS_IN
{
	float4 texcoord : TEXCOORD;
	float2 texcoord1 : TEXCOORD1;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0.x = 1 / i.texcoord.w;
	r0 = r0.x * i.texcoord.xyxy;
	r0 = r0 * float4(0.5, -0.5, 0.5, -0.5) + 0.5;
	r1 = r0.zwzw + -g_Rate.xyxy;
	r2 = r1.zwzw * g_Blur.xxyy + r0;
	r0 = r1 * g_Blur.zzww + r0;
	r1 = tex2D(g_Sampler1, r2);
	r2 = tex2D(g_Sampler1, r2.zwzw);
	r1.xyz = r1.xyz + r2.xyz;
	r2 = tex2D(g_Sampler1, r0);
	r0 = tex2D(g_Sampler1, r0.zwzw);
	r1.xyz = r1.xyz + r2.xyz;
	r0.xyz = r0.xyz + r1.xyz;
	r0.xyz = r0.xyz * g_MatrialColor.xyz;
	o.xyz = r0.xyz * 0.25;
	r0 = tex2D(g_Sampler2, i.texcoord1);
	r0.x = r0.w;
	o.w = r0.x * g_MatrialColor.w;

	return o;
}
