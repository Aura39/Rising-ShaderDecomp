float4 g_MatrialColor;
sampler g_Sampler;

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0 = tex2D(g_Sampler, texcoord);
	r0.w = r0.y * r0.x;
	r0.w = r0.z * r0.w;
	r0.x = dot(r0.xyz, 0.9933704);
	r0.x = r0.x + g_MatrialColor.x;
	r0.x = r0.x * -g_MatrialColor.y + g_MatrialColor.z;
	r0.xy = r0.xx * float2(256, 65536);
	r0.z = frac(r0.w);
	r0.z = -r0.z + r0.w;
	r1 = -r0.z + 0.5;
	clip(r1);
	r0.zw = frac(r0.xy);
	r0.xy = -r0.zw + r0.xy;
	o.z = r0.w;
	r0.xy = r0.xy * float2(0.0039192634, 0.00390625);
	o.y = frac(r0.y);
	o.xw = r0.xx * float2(1, 0) + 0;

	return o;
}
