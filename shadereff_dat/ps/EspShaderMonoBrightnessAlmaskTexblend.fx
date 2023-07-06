float4 g_BlendRate;
float4 g_MatrialColor;
float4 g_Rate;
sampler g_Sampler0;
sampler g_Sampler1;
sampler g_Sampler2;

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0 = tex2D(g_Sampler0, texcoord);
	r1 = tex2D(g_Sampler2, texcoord);
	r2 = lerp(r1, r0, g_BlendRate.x);
	r0.x = max(r2.x, r2.y);
	r1.x = max(r0.x, r2.z);
	r0.x = r1.x * g_Rate.x;
	r0.y = dot(r2.xyz, 0.298912);
	r0.x = r0.x * r0.y;
	r0.x = r0.x * 0.39215687;
	o.xyz = r0.xxx * g_MatrialColor.xyz;
	r0 = tex2D(g_Sampler1, texcoord);
	r0.x = r0.w * r2.w;
	r0.w = g_MatrialColor.w;
	r1 = r0.x * r0.w + -0.0001;
	r0.x = r0.x * g_MatrialColor.w;
	o.w = r0.x;
	clip(r1);

	return o;
}
