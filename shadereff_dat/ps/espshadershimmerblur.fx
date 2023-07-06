float4 g_Blur;
float4 g_MatrialColor;
float4 g_Rate;
sampler g_Sampler0;
sampler g_Sampler1;

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
	r0.x = 1 / i.texcoord1.w;
	r0.xy = r0.xx * i.texcoord1.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r1 = tex2D(g_Sampler0, i.texcoord);
	r0.zw = r1.xy + g_Rate.zw;
	r0.xy = r0.zw * g_Rate.xy + r0.xy;
	r0.zw = float2(0.5, -0.5);
	r1 = g_Blur.yyxy * r0.zwwz + r0.xyxy;
	r0 = g_Blur.yyxy * abs(r0.zwwz) + r0.xyxy;
	r2 = tex2D(g_Sampler1, r1);
	r1 = tex2D(g_Sampler1, r1.zwzw);
	r1.xyz = r1.xyz + r2.xyz;
	r2 = tex2D(g_Sampler1, r0);
	r0 = tex2D(g_Sampler1, r0.zwzw);
	r1.xyz = r1.xyz + r2.xyz;
	r0.xyz = r0.xyz + r1.xyz;
	r0.xyz = r0.xyz * g_MatrialColor.xyz;
	o.xyz = r0.xyz * 0.25;
	o.w = g_MatrialColor.w;

	return o;
}
