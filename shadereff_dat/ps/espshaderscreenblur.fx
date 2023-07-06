float4 g_Blur;
float4 g_MatrialColor;
float4 g_Rate;
sampler g_Sampler1;

float4 main(float4 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0.x = 1 / texcoord.w;
	r0 = r0.x * texcoord.xyxy;
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
	o.w = g_MatrialColor.w;

	return o;
}
